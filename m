Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 08:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345099AbiBUIv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:51:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345006AbiBUIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119CF2BC6;
        Mon, 21 Feb 2022 00:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C22A5B80E9E;
        Mon, 21 Feb 2022 08:51:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025D2C340E9;
        Mon, 21 Feb 2022 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645433479;
        bh=Lim3T8/XpP1tzJ2XS/T3UdzaZrkyAsB9C6diP9kTfmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lgCJ+MeqGmR6jHjlVHKoYlWzjTqs5I4OzwCUYpYjoTE9wKD7BQtkTFN+1MtuGnNCe
         sGT604cvYl4Co5EKFjkODNR/tAdsn9OoE5wV5wpHFPov2Ui8xz3fCb8CU8SG5iT2zS
         guAbu0yRbVWV4twG8/Or5Ev1/x8iEaLyyV0nZrzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicholas Bishop <nicholasbishop@google.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 14/33] drm/radeon: Fix backlight control on iMac 12,1
Date:   Mon, 21 Feb 2022 09:49:07 +0100
Message-Id: <20220221084909.241378621@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084908.568970525@linuxfoundation.org>
References: <20220221084908.568970525@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Bishop <nicholasbishop@google.com>

commit 364438fd629f7611a84c8e6d7de91659300f1502 upstream.

The iMac 12,1 does not use the gmux driver for backlight, so the radeon
backlight device is needed to set the brightness.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1838
Signed-off-by: Nicholas Bishop <nicholasbishop@google.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/atombios_encoders.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -192,7 +192,8 @@ void radeon_atom_backlight_init(struct r
 	 * so don't register a backlight device
 	 */
 	if ((rdev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
-	    (rdev->pdev->device == 0x6741))
+	    (rdev->pdev->device == 0x6741) &&
+	    !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
 		return;
 
 	if (!radeon_encoder->enc_priv)


