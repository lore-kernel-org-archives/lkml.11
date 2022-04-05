Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24937C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 12:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351042AbiDEMIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244444AbiDEIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:52:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4582D5EAB;
        Tue,  5 Apr 2022 01:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBA6361003;
        Tue,  5 Apr 2022 08:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43CEC385A0;
        Tue,  5 Apr 2022 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649148061;
        bh=XQzzdibhL0otRHSkdbIMNyKyXU70t8rbk4JAHgEy2QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWkArbK+yfYpQKkODEzTd86MzG3Bpl5PPFpAY95G5DokSkiHSZosArYmkL8pMvcnq
         cLEUsdxbtcyNi51Cz1pjDpqn6e9KrxeTUgJB0iNLt+kTSPemU1HZ+aIAaEK1j9KTJc
         BuwUoqJoYS3GnT5dduYJG3lX64GeXwnHJ+rJ17Q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 5.16 0187/1017] drm/nouveau/backlight: Fix LVDS backlight detection on some laptops
Date:   Tue,  5 Apr 2022 09:18:20 +0200
Message-Id: <20220405070359.790951126@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit 6b0076540faffd47f5a899bf12f3528c4f0e726b upstream.

It seems that some laptops will report having both an eDP and LVDS
connector, even though only the LVDS connector is actually hooked up. This
can lead to issues with backlight registration if the eDP connector ends up
getting registered before the LVDS connector, as the backlight device will
then be registered to the eDP connector instead of the LVDS connector.

So, fix this by only registering the backlight on connectors that are
reported as being connected.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 6eca310e8924 ("drm/nouveau/kms/nv50-: Add basic DPCD backlight support for nouveau")
Bugzilla: https://gitlab.freedesktop.org/drm/nouveau/-/issues/137
Cc: <stable@vger.kernel.org> # v5.15+
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220204180504.328999-1-lyude@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_backlight.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -294,7 +294,8 @@ nv50_backlight_init(struct nouveau_backl
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
 
-	if (!nvif_rd32(device, NV50_PDISP_SOR_PWM_CTL(ffs(nv_encoder->dcb->or) - 1)))
+	if (!nvif_rd32(device, NV50_PDISP_SOR_PWM_CTL(ffs(nv_encoder->dcb->or) - 1)) ||
+	    nv_conn->base.status != connector_status_connected)
 		return -ENODEV;
 
 	if (nv_conn->type == DCB_CONNECTOR_eDP) {


