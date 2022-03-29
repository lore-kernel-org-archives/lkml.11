Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B44C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 13:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiC2N1d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 09:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbiC2N1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:27:30 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B9E1F044F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:25:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KSVZs6hckzBrkF;
        Tue, 29 Mar 2022 21:21:41 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 21:25:44 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/8] A few cleanup and fixup patches for migration
Date:   Tue, 29 Mar 2022 21:26:11 +0800
Message-ID: <20220329132619.18689-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
This series contains a few patches to remove obsolete comment, introduce
helper to remove duplicated code and so no. Also we take all base pages
of THP into account in rare race condition. More details can be found in
the respective changelogs. Thanks!

Miaohe Lin (8):
  mm/vmscan: remove redundant folio_test_swapbacked check when folio is
    file lru
  mm/vmscan: remove unneeded can_split_huge_page check
  mm/vmscan: introduce helper function reclaim_page_list()
  mm/vmscan: save a bit of stack space in shrink_lruvec
  mm/vmscan: use helper folio_is_file_lru()
  mm/vmscan: take all base pages of THP into account when race with
    speculative reference
  mm/vmscan: take min_slab_pages into account when try to call
    shrink_node
  mm/vmscan: remove obsolete comment in kswapd_run

 mm/vmscan.c | 68 +++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

-- 
2.23.0

