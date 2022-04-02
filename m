Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5236EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 08:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343775AbiDBIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Apr 2022 04:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiDBIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:37:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2D15855C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 01:35:29 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVr0p4R4PzgY95;
        Sat,  2 Apr 2022 16:33:46 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 2 Apr 2022 16:35:27 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 2 Apr 2022 16:35:27 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <zhongjubin@huawei.com>
CC:     <akpm@linux-foundation.org>, <lasse.collin@tukaani.org>,
        <liaohua4@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <nixiaoming@huawei.com>, <wangfangpeng1@huawei.com>
Subject: Re: [PATCH v2 RESEND] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Sat, 2 Apr 2022 16:35:23 +0800
Message-ID: <1648888523-116677-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <1648435711-95240-1-git-send-email-zhongjubin@huawei.com>
References: <1648435711-95240-1-git-send-email-zhongjubin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.

