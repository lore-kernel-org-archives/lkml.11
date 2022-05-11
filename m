Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87949C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 01:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240284AbiEKBZX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 21:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiEKBZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:25:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDFD80B5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:25:18 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kycb83lvKzGpl2;
        Wed, 11 May 2022 09:22:28 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:16 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 11 May 2022 09:25:16 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ryan.lee.analog@gmail.com>, <ricardw@axis.com>, <steve@sk2.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH -next 0/2] ASoC: codecs: Fix build error
Date:   Wed, 11 May 2022 09:23:46 +0800
Message-ID: <20220511012348.94288-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two build error, as follows:

tanghui (2):
  ASoC: max98396: Fix build error for implicit function declaration
  ASoC: tlv320adc3xxx: Fix build error for implicit function declaration

 sound/soc/codecs/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.17.1

