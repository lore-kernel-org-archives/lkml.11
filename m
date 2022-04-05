Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34DC4167B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349231AbiDELDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiDEIlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE3111C;
        Tue,  5 Apr 2022 01:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E0D60B0A;
        Tue,  5 Apr 2022 08:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0FDC385A2;
        Tue,  5 Apr 2022 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147652;
        bh=tv6arKi6rzEnPZRRIbINOvlsb8nTYzIr7Tyyr02e010=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5WO8Pnwcb3Yv63DSeEXIzZRM+3uDundALUQ+zibrZq50JjMufdfx92LlkgpDSpQW
         ePFZG0iEzgyz4bZaaVNVbzx/PxSA1Rg0odhu/IcKu17Jd6gPh/PFgKbE7cWTqUxgEe
         KU69HTc9LDhSrl4kyKTHj6rq5scEEXHGowFzCHBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.16 0035/1017] xhci: fix runtime PM imbalance in USB2 resume
Date:   Tue,  5 Apr 2022 09:15:48 +0200
Message-Id: <20220405070355.221652878@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Lin <henryl@nvidia.com>

commit 70c05e4cf63054cd755ca66c1819327b22cb085f upstream.

A race between system resume and device-initiated resume may result in
runtime PM imbalance on USB2 root hub. If a device-initiated resume
starts and system resume xhci_bus_resume() directs U0 before hub driver
sees the resuming device in RESUME state, device-initiated resume will
not be finished in xhci_handle_usb2_port_link_resume(). In this case,
usb_hcd_end_port_resume() call is missing.

This changes calls usb_hcd_end_port_resume() if resuming device reaches
U0 to keep runtime PM balance.

Fixes: a231ec41e6f6 ("xhci: refactor U0 link state handling in get_port_status")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Lin <henryl@nvidia.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20220303110903.1662404-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-hub.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1088,6 +1088,9 @@ static void xhci_get_usb2_port_status(st
 		if (link_state == XDEV_U2)
 			*status |= USB_PORT_STAT_L1;
 		if (link_state == XDEV_U0) {
+			if (bus_state->resume_done[portnum])
+				usb_hcd_end_port_resume(&port->rhub->hcd->self,
+							portnum);
 			bus_state->resume_done[portnum] = 0;
 			clear_bit(portnum, &bus_state->resuming_ports);
 			if (bus_state->suspended_ports & (1 << portnum)) {


