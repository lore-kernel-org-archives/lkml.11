Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBA3C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 20:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbiHLUJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiHLUJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:09:18 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786BB74E2E
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:09:13 -0700 (PDT)
Received: from workstation5.fritz.box (ip-062-143-094-109.um16.pools.vodafone-ip.de [62.143.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3B9743F4C2;
        Fri, 12 Aug 2022 20:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1660334947;
        bh=1BTNGPLXVytY7MPrEFoGsJ4XchIM8uVLAazWA/Ntebk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=NgGrVPro1+n1XVgShsoVKBVhf/wiqRIJt6AmkfYiGUEZrQGHmC3DpVMaG8UN/zf03
         liQp6u6on6/gY2cB1uoK84+M9OiG6Te410KFs+5oQHobeGHTiZ3b+BSTSMOcyjx6f5
         23JO/ye1ZxuDhbRk3YJsyjGq86lVCo/TWAW0uikqc1F118O1RwIJuasPMbwOia3IZD
         ZdotSdQQGPyc5PqBJWYNdDPxbqsHf1E9SKbAmDmZTrgkwC2aSuBUIn14gdp/nCiTRu
         WXAoPSQrU++yjaIHTUWjp85bD4ZPQZ1qlBS6GaGOcK3b97LBr/8X4caCrueB8sjDre
         oK6k5J/+jAqBw==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: enable CD-ROM file systems in defconfig
Date:   Fri, 12 Aug 2022 22:08:53 +0200
Message-Id: <20220812200853.311474-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CD-ROM images are still commonly used for installer images and other
data exchange.

These file systems should be supported on RISC-V by default
like they are on x86_64.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index aed332a9d4ea..05fd5fcf24f9 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -166,6 +166,9 @@ CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_OVERLAY_FS=m
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
2.36.1

