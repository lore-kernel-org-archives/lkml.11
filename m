Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE82C3527B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351500AbiBUJhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:37:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349196AbiBUJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:27:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F8237D7;
        Mon, 21 Feb 2022 01:12:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A514DCE0E88;
        Mon, 21 Feb 2022 09:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1576C340E9;
        Mon, 21 Feb 2022 09:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434755;
        bh=qdKhP+Yu3uEce58zCR/FGGWQkn0rFoSPSBzckS41AFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3TYtWOX7VcDnB2USDFGzyybGIW+hh9b0SaRdXzlTiYSlLTO7lcgWVZaWmEIZrIsV
         9DIEBeqpiG8pzO2uwnYYXVNA7QTwds24h+iMB1wa+4wGDn8p6W9Xb0WcqF+V0RmN2H
         OHSyMh/Z2/5Sm1s9e6sVkfc9JqBn0U7h9upnXOxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 5.15 087/196] brcmfmac: firmware: Fix crash in brcm_alt_fw_path
Date:   Mon, 21 Feb 2022 09:48:39 +0100
Message-Id: <20220221084933.841627872@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084930.872957717@linuxfoundation.org>
References: <20220221084930.872957717@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.com>

commit 665408f4c3a5c83e712871daa062721624b2b79e upstream.

The call to brcm_alt_fw_path in brcmf_fw_get_firmwares is not protected
by a check to the validity of the fwctx->req->board_type pointer. This
results in a crash in strlcat when, for example, the WLAN chip is found
in a USB dongle.

Prevent the crash by adding the necessary check.

See: https://github.com/raspberrypi/linux/issues/4833

Fixes: 5ff013914c62 ("brcmfmac: firmware: Allow per-board firmware binaries")
Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20220118154514.3245524-1-phil@raspberrypi.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
@@ -693,7 +693,7 @@ int brcmf_fw_get_firmwares(struct device
 {
 	struct brcmf_fw_item *first = &req->items[0];
 	struct brcmf_fw *fwctx;
-	char *alt_path;
+	char *alt_path = NULL;
 	int ret;
 
 	brcmf_dbg(TRACE, "enter: dev=%s\n", dev_name(dev));
@@ -712,7 +712,9 @@ int brcmf_fw_get_firmwares(struct device
 	fwctx->done = fw_cb;
 
 	/* First try alternative board-specific path if any */
-	alt_path = brcm_alt_fw_path(first->path, fwctx->req->board_type);
+	if (fwctx->req->board_type)
+		alt_path = brcm_alt_fw_path(first->path,
+					    fwctx->req->board_type);
 	if (alt_path) {
 		ret = request_firmware_nowait(THIS_MODULE, true, alt_path,
 					      fwctx->dev, GFP_KERNEL, fwctx,


