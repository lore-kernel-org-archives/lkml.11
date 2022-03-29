Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 07:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiC2HbL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiC2HbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:31:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788A2AE6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b15so15144463pfm.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTbD7jGgh/KLDDWua+lhKitl7ix/55ibmUsyIxaned4=;
        b=UEarIBkXggU6f1IDuuLRahcOyLDmhoTwhhFad0YQS6tczcmbGtfopV40XNg0dlMLV9
         5kE3fh2S0koV0yDrG3x5lFHmuc5mobUwE5bD2DMFbDfCAzYfhhYeRsrprilqKrN3zrHq
         1w7Pfts/TuEemwSOWKOH4G1E5Qby4wB1xCfe+Pfj/zWTaGpvk0T1OYPiQRsTGDfyx9id
         Q/x2xfJ8PJUeYs5uvJC7i9NQ4aBP42ucW5mOFhOvtXsT4966C9S3M2Q1WYSslEJ7Akdr
         pUEtEkn6i7WTWvf1jywickNrM6pC0HcBP+7Skped0Jwd/GAdpSxARqtAAqyPy2EpqVBv
         ediQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UTbD7jGgh/KLDDWua+lhKitl7ix/55ibmUsyIxaned4=;
        b=RzngHKXiohh49PkoJR6YLsvaOj2qYxyh/YpHu0T0bl0rwkh1R1sBtu1hpcWpWAavxT
         sdjVLBA7iAqh/ATHSUa9Su0NlzR2I1riXEF+d2Q8awa858BcIqygCcFwN6DM0QfdLBKS
         SbreKQq5ncYUmECMOxyvt5IZs//rvU8gof5bP46ZlsrpwqOkt71khizPb82+1uWGDDPU
         A95N2Bj9obGbRiwL0OSRCyqxJGbyKofghp7Ynk1NWH1X0BFDgXSphTjLTcZC+HnsqFl+
         e0h5VYBT9yMCU62UjDOG5Q0SW4PTMnh9HYrQNrRq//lgi9oO3GtmPASgy+JRe713y85r
         Qzqg==
X-Gm-Message-State: AOAM533ZJ1EQelikBBNrAhYwLyAZ32eQ53kAwtwnQbblpnEj5Xc/ZyoS
        g6abIdkpWc2g6hCjL6QMzjTgBw==
X-Google-Smtp-Source: ABdhPJwIkpl4g0Z0faxh1E9Z+gpMHgVpjDzUMRtKVIvn6DAguqbIiaRi5u4NO2ReAR8iEzODdyEFMA==
X-Received: by 2002:a63:211b:0:b0:382:6f4e:3408 with SMTP id h27-20020a63211b000000b003826f4e3408mr1061874pgh.515.1648538967322;
        Tue, 29 Mar 2022 00:29:27 -0700 (PDT)
Received: from localhost.localdomain ([122.171.166.231])
        by smtp.gmail.com with ESMTPSA id z6-20020a056a00240600b004e17ab23340sm19440564pfh.177.2022.03.29.00.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:29:26 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 0/3] Unexpected guest trap handling for KVM RISC-V selftests
Date:   Tue, 29 Mar 2022 12:59:08 +0530
Message-Id: <20220329072911.1692766-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Getting unexpected guest traps while running KVM RISC-V selftests should
cause the test to fail appropriately with VCPU register dump. This series
improves handling of unexpected traps along these lines.

These patches can also be found in riscv_kvm_selftests_unexp_trap_v1 branch
at: https://github.com/avpatel/linux.git

Anup Patel (3):
  KVM: selftests: riscv: Set PTE A and D bits in VS-stage page table
  KVM: selftests: riscv: Fix alignment of the guest_hang() function
  KVM: selftests: riscv: Improve unexpected guest trap handling

 .../selftests/kvm/include/riscv/processor.h   | 12 ++++---
 .../selftests/kvm/lib/riscv/processor.c       |  9 +++---
 tools/testing/selftests/kvm/lib/riscv/ucall.c | 31 +++++++++++++------
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.25.1

