Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5C8C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243276AbiBNJ3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 04:29:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243126AbiBNJ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:29:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C88B60D80;
        Mon, 14 Feb 2022 01:28:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF6D360F8A;
        Mon, 14 Feb 2022 09:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE96CC340E9;
        Mon, 14 Feb 2022 09:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644830936;
        bh=vO4Q/ESMka9w3K0f1kTJOq7adSxZDZCYb+dKNb6/x1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYE01CJ33CISTe0S3ozaguTyDRhAC7Ip9DXKTvxrJ0ZSFBuopGXxT2Nrp+J6o39cs
         NBoFWIkkIIyJ6PnP3+5EkKOzwFKfThP3SxHRGWPlr8DBlKEbU5uZNF0tKp68KhK9XJ
         vU1Omm+VZPOz7TKdgZTxLOoVeZjvwI1rQL8fGSi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Szymon Heidrich <szymon.heidrich@gmail.com>, stable@kernel.org
Subject: [PATCH 4.9 28/34] usb: gadget: rndis: check size of RNDIS_MSG_SET command
Date:   Mon, 14 Feb 2022 10:25:54 +0100
Message-Id: <20220214092446.859673261@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214092445.946718557@linuxfoundation.org>
References: <20220214092445.946718557@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 38ea1eac7d88072bbffb630e2b3db83ca649b826 upstream.

Check the size of the RNDIS_MSG_SET command given to us before
attempting to respond to an invalid message size.

Reported-by: Szymon Heidrich <szymon.heidrich@gmail.com>
Cc: stable@kernel.org
Tested-by: Szymon Heidrich <szymon.heidrich@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/rndis.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -642,14 +642,17 @@ static int rndis_set_response(struct rnd
 	rndis_set_cmplt_type *resp;
 	rndis_resp_t *r;
 
+	BufLength = le32_to_cpu(buf->InformationBufferLength);
+	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
+	if ((BufLength > RNDIS_MAX_TOTAL_SIZE) ||
+	    (BufOffset + 8 >= RNDIS_MAX_TOTAL_SIZE))
+		    return -EINVAL;
+
 	r = rndis_add_response(params, sizeof(rndis_set_cmplt_type));
 	if (!r)
 		return -ENOMEM;
 	resp = (rndis_set_cmplt_type *)r->buf;
 
-	BufLength = le32_to_cpu(buf->InformationBufferLength);
-	BufOffset = le32_to_cpu(buf->InformationBufferOffset);
-
 #ifdef	VERBOSE_DEBUG
 	pr_debug("%s: Length: %d\n", __func__, BufLength);
 	pr_debug("%s: Offset: %d\n", __func__, BufOffset);


