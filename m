Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECBC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 05:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbiCXFc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 01:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347117AbiCXFcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:32:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF290FCA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:31:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so8471097pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 22:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QipneOKTQA94tj99xDqNJKu1O2H8ssVgZVHFopSbC+M=;
        b=C5mGlEIKX4AWJlHVpauTVvB1V3nbesh9rYgkVht4cmoudIeXr83jAVOCcnuKjdxCj3
         ll6uI1LWyqz3e65iD7SYEM8zrl5aYpvlCJ6TGQwUXDcbAAoidQNq5iTUKrs8n0g67oaw
         Plp3VhPSPaz/Za9aKPahuqpkO327MUBmFDn9gaHk7o2EmdtCcHLG47R7o11CLVeV+0Lz
         UdXdh7WdHp0vZI07iDNxk4lqGsgOWSKxBkYf/vGfvVaEmj5jOkRMy+OC8/a8J5qAw09p
         ifCLQBeNwtED603uCRuD1ackl/Jnt9fzxJJBw9Artkzm7vuiTc5Sob1SXiHu5bHfDpuG
         8ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QipneOKTQA94tj99xDqNJKu1O2H8ssVgZVHFopSbC+M=;
        b=KVnKISRFnMeiDqxDOcFbCwQP2lBD5JUb0ASNRYell9QCdsgNFXDaODYcmO3BDMN9Sz
         q8mBlgPGrU1DqRr1JcWEbylgatokJrvN0az5Eu8Qis1lMVlTaj1xhPCD26fe/+J/S0SD
         iFro1nLghEtsfH5i8ETrwULMwI1THWL+t/3+PcXunz75lnonUArv+q1/g7FF5bEsmsO0
         BniUb9iK0rFjq3f0yyfMmUkRxj7vfWGmWtwWqsk6tvIl01Gh8lQDpnDKybqvO1kfIeSx
         KFZwwQabbm8kxHAif0vtQRxngkn3yfklnuQwbPzv3XE7HIU5W6uzAvz+30QBUgr/uf4i
         JncQ==
X-Gm-Message-State: AOAM5304bmlEarRIJUl54t8QWgIn0NoZRp2gYFlhN7T0J9Q7rPPG9O/C
        5shsEJ7K8w0r9/mc2bTAJ4MVS7+KOCUjMw==
X-Google-Smtp-Source: ABdhPJzJ23XG52EA/bmvEIHgik5fGswJ/31WIMHu5gBxwc/4KUviZwOOxTxAZQRkGfjJNyveMriTjA==
X-Received: by 2002:a17:903:281:b0:14c:f3b3:209b with SMTP id j1-20020a170903028100b0014cf3b3209bmr3906079plr.87.1648099883419;
        Wed, 23 Mar 2022 22:31:23 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00248400b004faad8c81bcsm1705069pfv.127.2022.03.23.22.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 22:31:22 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v2] RISC-V: Enable profiling by default
Date:   Thu, 24 Mar 2022 11:00:20 +0530
Message-Id: <20220324053020.606637-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let us enable profiling by default in RV32 and RV64 defconfigs so
that we can use RISC-V PMU drivers on various RISC-V platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
Changes since v1:
 - Enable CONFIG_PROFILING instead of CONFIG_PREF_EVENTS in defconfigs
---
 arch/riscv/configs/defconfig      | 1 +
 arch/riscv/configs/rv32_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index f120fcc43d0a..bfebee46784c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_PROFILING=y
 CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index 8b56a7f1eb06..2b68b1bd2559 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -15,6 +15,7 @@ CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
+CONFIG_PROFILING=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_VIRT=y
 CONFIG_ARCH_RV32I=y
-- 
2.25.1

