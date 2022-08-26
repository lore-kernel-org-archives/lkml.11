Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE9AECAAA3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 06:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiHZGzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 02:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbiHZGz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:55:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D66E2E1;
        Thu, 25 Aug 2022 23:55:20 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MDVqj73x6z19Vbg;
        Fri, 26 Aug 2022 14:51:45 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (7.185.36.155) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 14:54:49 +0800
Received: from huawei.com (10.67.175.33) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 14:54:49 +0800
From:   Lin Yujun <linyujun809@huawei.com>
To:     <corbet@lwn.net>, <bp@suse.de>, <keescook@chromium.org>,
        <aarcange@redhat.com>, <daniel.sneddon@linux.intel.com>,
        <longman@redhat.com>, <lukas.bulwahn@gmail.com>,
        <peterz@infradead.org>, <kim.phillips@amd.com>,
        <linyujun809@huawei.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] Documentation/hw-vuln: Update spectre doc
Date:   Fri, 26 Aug 2022 14:51:32 +0800
Message-ID: <20220826065132.112340-1-linyujun809@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.33]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch adds the specre_v2=ibrs option in
Documentation/admin-guide/kernel-parameters.txt
but omits it to
Documentation/admin-guide/hw-vuln/spectre.rst

commit 7c693f54c873691 ("x86/speculation: Add spectre_v2=ibrs option to support Kernel IBRS")

Supplement the specre_v2=ibrs option to
Documentation/admin-guide/hw-vuln/spectre.rst

Signed-off-by: Lin Yujun <linyujun809@huawei.com>
---
 Documentation/admin-guide/hw-vuln/spectre.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 2ce2a38cdd55..c4dcdb3d0d45 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -613,6 +613,7 @@ kernel command line.
                 eibrs                   enhanced IBRS
                 eibrs,retpoline         enhanced IBRS + Retpolines
                 eibrs,lfence            enhanced IBRS + LFENCE
+                ibrs                    use IBRS to protect kernel
 
 		Not specifying this option is equivalent to
 		spectre_v2=auto.
-- 
2.17.1

