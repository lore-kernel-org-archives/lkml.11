Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632ACC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 06:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiCXGpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbiCXGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:45:15 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5113C8FE5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 23:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648104218;
        bh=fjYplXUxWwaBwzbAUquO5tJoKkhAeRwrA4rqKKHb394=;
        h=From:To:Cc:Subject:Date;
        b=tpnVkexjRnMfYpFKUhtgqGUmbdgu3AARWe3utbEChJ/X6HX8A6GQR2EaYaTyR1gw2
         fSfSqOaJ0eZxZZ6s1cCZ/7wqjjYYHJl+obZM7Ya6iYHysQWS/4dnPxKtPjydCxH3It
         8DK6Pzq/rHED8xlPRZ8Z7dKCYy8xBuKOG8tur+dI=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id ADD0A0CE; Thu, 24 Mar 2022 14:43:29 +0800
X-QQ-mid: xmsmtpt1648104209trrbo5h6n
Message-ID: <tencent_92B89C12C6BF29881C73666E140718054E06@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NozOAi+JJCABGcHmzsemUO/GRu6RgZ2QzoD03us3gthe9Ml9fTkt
         t6r2nv/I/gmdkKmp9jHey7E3O+SKG46MKY4/HjPYEu3T49iDan7Z1Ur26WU6Etfwz1N4GIfgnyK7
         WG6LL7jckq60jdclWh9Rn5NxroJ/641aeEjxwPPmTciDXD7ON2ln0/GaKzqVguVILlmWNk700vy6
         9K9umAZBonInWLeYHRx2gWsgavHDjcppBlj1vvc092v/OxFAS/r/BqWCqR3mXc+10e/0JuSBVtbO
         fGZ8iIdPfI2uARW0/bgpRZa12JmcSw2+ZcrSJSGjbXogFNS9HTZGXkeB/opKwIhfJw5MPzP2BOCc
         QH+1byIm+LLpBgoN4Q0Aa5HaHB0UhmERf8qGxllIHi3RCcodXx1aNB6evtFvaueRyCHKA8Id0Mqx
         Hzfee2nKLx52jWGzsqAqU2qSQpqZszupm6Gj6lszYURe/d/asmhxSq8hJYudqCeaG39qqMlvpJ0e
         v11X5WAf/1KvOfW5N6Sbny5c8p4fWpOCM/oN74OtqTOI5GioTWvm6h+2WOxOTM0GV1rBP/URb6W/
         34T1EGaXXsIBQf5vELHQc95AXy8wUWebTMfpTrs5cH8Jw1Jd8/Fz59zoO05ipZZcO0bbvd0BPJWU
         qWnzMZ1H90/e7Lzi/fvElTNsRiFTQ5hActHA7XP+zSlgeOLVn7jpUn5Cl7Xl43bJkCV9fEAMHal5
         SD5hJtnAgFwd8PoEeTltbitA6PsfyTI3vwaSOHUX7BOqmD6eH6z99imx8UeoRhom1G8Rkt+9gpLl
         RRN/sMjP3HDrbf2rFdyHW3qr57/JKqlCQXAYzdehl6xyW0GP3+UWQkvM7CFGJ8FMTZQ6cT3BNW68
         pk6kLtPL1gFqKCjSVQ58yILwLXQsCPkbjgOjLqzwtViw4uwo00AOafNZnYoA1P6CnHGeSk52Q2XA
         dT7w5Tt06O22CjoI6aAFHucXfX7vZnaVkF8RLeuLw=
From:   xkernel.wang@foxmail.com
To:     liviu.dudau@arm.com, brian.starkey@arm.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] drm: mali-dp: check the return value of kzalloc()
Date:   Thu, 24 Mar 2022 14:43:17 +0800
X-OQ-MSGID: <20220324064317.2424-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f5847a7..0720b21 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -70,7 +70,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
-- 
