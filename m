Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343707AbiDNWIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiDNWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:07:46 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB428AD134
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:05:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 2so6301783pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=GsO1g7Ro+rsf0io9vopg1aQfP2P2g91oLlrkEyQDXiM=;
        b=CnWghtB/dN2XPpzq+zptNtM2MAL+NMPVHYsMQgwsTW7iLpCdsO92al51pP1s30INYy
         rwF44VxtoSsNlb8TLR6+PvivGyCZ5apI54By81gsXp8b4zJytpT14My0wRS1/XqlEqjn
         9c60+wgJ448Ym18jElwrZxwugKHQ2CLL8h38oEC7pO1P/00c1v34g1qQ6JgcV2POF6XJ
         qT35OQ8QyKY5rNXOS1abuXba/eh8yrBZrITli2mG/rjIegR5xxQLu6j+6zg8d/wJOC96
         t/JZMK7hUZ/uW4d5apxoZB276EgBxBgsh8TDMlVDZJzUdBERoLCAWxBKRYX15Cr0EDe1
         B80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=GsO1g7Ro+rsf0io9vopg1aQfP2P2g91oLlrkEyQDXiM=;
        b=gumRlgpxksQT8l+tpTcGHqRlSOEBDUPk8mK9oYU4C/v1Zdx8z0DgFt3yRwPSpl35QW
         MflzRfA22aSSKIxMY8DjfhnoH/heR5PGuhxEtqRyqESSKN7u9iFen9PXFO7Jl1wOdrOs
         EmJgtm8vHzbvA+u+Ke/q8z9Cdzww0vDYRaxndY/UbWg3M9wXsG/hCThSWBNGVLElqdR1
         LY4hO+paTGWTz3w58H4dJT4k2GdBYr5qkxKB2Kj+Z31YZXu5Ff71EByVbhR7FrssJtcm
         A0iYb6NiiSQOBb2/+uxwSEThYSt+lknc3CUsSL5IofR0GRHIACURSfcp40LklGXV4ET+
         H+Cg==
X-Gm-Message-State: AOAM531w7CGVpJWNrmnyxfVnlY7RRQ9jaV7WCo+7tZVw2Dg1LhJFDviq
        CdEQNCe0eM1UDOxdBshMK/DFPw==
X-Google-Smtp-Source: ABdhPJyLfdcVDkvOFuUrfAfCBiI+o5Yu4ll2mvpNoDdi2mqGNotIaUVXICITBKPJFNtsKr9Rm/qRqw==
X-Received: by 2002:a17:902:eb82:b0:158:8feb:86d6 with SMTP id q2-20020a170902eb8200b001588feb86d6mr13587063plg.26.1649973918225;
        Thu, 14 Apr 2022 15:05:18 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm2715141pjj.20.2022.04.14.15.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:05:17 -0700 (PDT)
Subject: [PATCH v3 3/7] asm-generic: qrwlock: Document the spinlock fairness requirements
Date:   Thu, 14 Apr 2022 15:02:10 -0700
Message-Id: <20220414220214.24556-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220214.24556-1-palmer@rivosinc.com>
References: <20220414220214.24556-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I could only find the fairness requirements documented as the C code,
this calls them out in a comment just to be a bit more explicit.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qrwlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..24ae09c1db9f 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -2,6 +2,10 @@
 /*
  * Queue read/write lock
  *
+ * These use generic atomic and locking routines, but depend on a fair spinlock
+ * implementation in order to be fair themselves.  The implementation in
+ * asm-generic/spinlock.h meets these requirements.
+ *
  * (C) Copyright 2013-2014 Hewlett-Packard Development Company, L.P.
  *
  * Authors: Waiman Long <waiman.long@hp.com>
-- 
2.34.1

