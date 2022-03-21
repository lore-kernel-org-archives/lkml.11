Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413FDC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 08:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345414AbiCUItj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 04:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243523AbiCUItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:49:33 -0400
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4DE833361;
        Mon, 21 Mar 2022 01:48:07 -0700 (PDT)
HMM_SOURCE_IP: 172.18.0.48:46324.1934642690
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-202.80.192.39 (unknown [172.18.0.48])
        by chinatelecom.cn (HERMES) with SMTP id D00D328008E;
        Mon, 21 Mar 2022 16:47:58 +0800 (CST)
X-189-SAVE-TO-SEND: +sunshouxin@chinatelecom.cn
Received: from  ([172.18.0.48])
        by app0024 with ESMTP id 09004b00fbe64a199fc569a236240e29 for j.vosburgh@gmail.com;
        Mon, 21 Mar 2022 16:48:04 CST
X-Transaction-ID: 09004b00fbe64a199fc569a236240e29
X-Real-From: sunshouxin@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: sunshouxin@chinatelecom.cn
From:   Sun Shouxin <sunshouxin@chinatelecom.cn>
To:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, oliver@neukum.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyd12@chinatelecom.cn, sunshouxin@chinatelecom.cn
Subject: [PATCH v5 0/4] Add support for IPV6 RLB to balance-alb mode
Date:   Mon, 21 Mar 2022 04:47:00 -0400
Message-Id: <20220321084704.36370-1-sunshouxin@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is implementing IPV6 RLB for balance-alb mode.

Sun Shouxin (4):
  net:ipv6:Add void *data to ndisc_send_na function
  net:ipv6:Refactor ndisc_send_na to support sending na by slave
    directly
  net:ipv6:Export inet6_ifa_finish_destroy and ipv6_get_ifaddr
  net:bonding:Add support for IPV6 RLB to balance-alb mode

 drivers/net/bonding/bond_3ad.c     |   2 +-
 drivers/net/bonding/bond_alb.c     | 592 ++++++++++++++++++++++++++++-
 drivers/net/bonding/bond_debugfs.c |  14 +
 drivers/net/bonding/bond_main.c    |   6 +-
 drivers/net/usb/cdc_mbim.c         |   3 +-
 include/net/bond_3ad.h             |   2 +-
 include/net/bond_alb.h             |   7 +
 include/net/bonding.h              |   6 +-
 include/net/ipv6_stubs.h           |   3 +-
 include/net/ndisc.h                |   9 +-
 net/ipv6/addrconf.c                |   4 +-
 net/ipv6/ndisc.c                   |  64 +++-
 12 files changed, 676 insertions(+), 36 deletions(-)


base-commit: 092d992b76ed9d06389af0bc5efd5279d7b1ed9f
-- 
2.27.0

