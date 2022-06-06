Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38BAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 15:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiFFP1S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbiFFPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:25:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB641CD371;
        Mon,  6 Jun 2022 08:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 927C1CE171A;
        Mon,  6 Jun 2022 15:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CD4C36AFF;
        Mon,  6 Jun 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654529148;
        bh=uYzTjH+e3o2wba+BCjbkvG145i25sH3OQNXdCWp/6mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/ythrFoXyH8f0IbIytHSh89GRdSbtgHbO+3oduT96C0MN2n9+0IeovKHcuPwrALu
         1LYYKGWyZmgovd0l9FwZGlR9NO7rZZVKoUtuFacnhohQKZ6/xhimqldLsuxwhC4dFA
         37YZHaZwHOm2nMV/w8Npki1ZaEssCLUDG2XMYOyNkOgH8zwqGqIH/KGa8rH8sBlxgS
         pCUmqbnR/DlrPy7JQUjf1VfYz4WYewl9fPvZFRM0hqEsgrS8H4c0Kv0kJ8z0TsdIaC
         SU8QiVAPib9Nkb3+qHaUQBdTWvemL0hDw0k6E8ZH6z6iuSBNXDt4sEXEwiFzcfqDX5
         cvc9Ei9N4e8SQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1nyEby-0012PW-AK;
        Mon, 06 Jun 2022 16:25:46 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/23] MAINTAINERS: update arm,hdlcd.yaml reference
Date:   Mon,  6 Jun 2022 16:25:36 +0100
Message-Id: <714c3b6e10736d51268b9d71b97829a224b3bae1.1654529011.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
renamed: Documentation/devicetree/bindings/display/arm,hdlcd.txt
to: Documentation/devicetree/bindings/display/arm,hdlcd.yaml.

Update its cross-reference accordingly.

Fixes: 36fd2a65bcaf ("dt-bindings: display: convert Arm HDLCD to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/23] at: https://lore.kernel.org/all/cover.1654529011.git.mchehab@kernel.org/

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..c20bd168d209 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1507,7 +1507,7 @@ F:	drivers/clocksource/arm_arch_timer.c
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-F:	Documentation/devicetree/bindings/display/arm,hdlcd.txt
+F:	Documentation/devicetree/bindings/display/arm,hdlcd.yaml
 F:	drivers/gpu/drm/arm/hdlcd_*
 
 ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
-- 
2.36.1

