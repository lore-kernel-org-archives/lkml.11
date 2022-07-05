Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CDBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 06:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGEG0U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 02:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGEG0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:26:17 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611AF5AF;
        Mon,  4 Jul 2022 23:26:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VIQwVCS_1657002372;
Received: from localhost(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0VIQwVCS_1657002372)
          by smtp.aliyun-inc.com;
          Tue, 05 Jul 2022 14:26:13 +0800
From:   Qiao Ma <mqaio@linux.alibaba.com>
To:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        kuba@kernel.org, gustavoars@kernel.org, cai.huoqing@linux.dev,
        aviad.krawczyk@huawei.com, zhaochen6@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 0/3] net: hinic: fix three bugs about dev_get_stats
Date:   Tue,  5 Jul 2022 14:25:58 +0800
Message-Id: <cover.1657001998.git.mqaio@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixes 3 bugs of hinic driver:
- fix bug that ethtool get wrong stats because of hinic_{txq|rxq}_clean_stats() is called
- avoid kernel hung in hinic_get_stats64() 
- fix bug that u64_stats_sync is not initialized

See every patch for more information.

Changes in v3:
- fixes a compile warning reported by kernel test robot <lkp@intel.com>

Changes in v2:
- fixes another 2 bugs. (v1 is a single patch, see: https://lore.kernel.org/all/07736c2b7019b6883076a06129e06e8f7c5f7154.1656487154.git.mqaio@linux.alibaba.com/).
- to fix extra bugs, hinic_dev.tx_stats/rx_stats is removed, so there is no need to use spinlock or semaphore now. 

Qiao Ma (3):
  net: hinic: fix bug that ethtool get wrong stats
  net: hinic: avoid kernel hung in hinic_get_stats64()
  net: hinic: fix bug that u64_stats_sync is not initialized

 drivers/net/ethernet/huawei/hinic/hinic_dev.h     |  3 --
 drivers/net/ethernet/huawei/hinic/hinic_ethtool.c |  3 ++
 drivers/net/ethernet/huawei/hinic/hinic_main.c    | 58 +++++++----------------
 3 files changed, 21 insertions(+), 43 deletions(-)

-- 
1.8.3.1

