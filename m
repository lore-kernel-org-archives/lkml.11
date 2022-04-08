Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 10:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiDHKMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiDHKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:12:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D9A997B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:10:08 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KZYpV2GTBzFpXh;
        Fri,  8 Apr 2022 18:07:46 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 18:10:06 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <palmer@dabbelt.com>, <liaochang1@huawei.com>
CC:     <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <bjorn.topel@gmail.com>,
        <ebiederm@xmission.com>, <guoren@linux.alibaba.com>,
        <jszhang@kernel.org>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <mick@ics.forth.gr>, <paul.walmsley@sifive.com>,
        <penberg@kernel.org>, <sunnanyong@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 -next 2/6] RISC-V: use memcpy for kexec_file mode
Date:   Fri, 8 Apr 2022 18:09:10 +0800
Message-ID: <20220408100914.150110-3-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220408100914.150110-1-lizhengyu3@huawei.com>
References: <20220408100914.150110-1-lizhengyu3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

The pointer to buffer loading kernel binaries is in kernel space for
kexec_fil mode, When copy_from_user copies data from pointer to a block
of memory, it checkes that the pointer is in the user space range, on
RISCV-V that is:

static inline bool __access_ok(unsigned long addr, unsigned long size)
{
	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
}

and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
copy_from_user to reject the access of the field 'buf' of struct
kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
CONFIG_PAGE_OFFSET), is invalid user space pointer.

This patch fixes this issue by skipping access_ok(), use mempcy() instead.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/riscv/kernel/machine_kexec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index cbef0fc73afa..df8e24559035 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -65,7 +65,9 @@ machine_kexec_prepare(struct kimage *image)
 		if (image->segment[i].memsz <= sizeof(fdt))
 			continue;
 
-		if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
+		if (image->file_mode)
+			memcpy(&fdt, image->segment[i].buf, sizeof(fdt));
+		else if (copy_from_user(&fdt, image->segment[i].buf, sizeof(fdt)))
 			continue;
 
 		if (fdt_check_header(&fdt))
-- 
2.17.1

