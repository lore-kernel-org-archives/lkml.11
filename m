Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2254EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 14:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbiCIO7z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 09:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbiCIO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 09:59:50 -0500
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C6150400
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 06:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1646837502; bh=0Yi318wfCJtWJqnapeaa1MNQLwwiuwfQxmD1DyHj7m8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=sbAOCSHhh5LbJ9KKA75H3TgifwYO2BiF665VHHzW7INn86Ee4/3fJBRcbQg67wz/Q
         NnStd7Afz5paBisYcsDwPBAFhFj7cnIbmyuV7Wi6qDX9FL189u1gn8B6ctVuSc2XnU
         DRrFeDXSuB8j/VTKGe0H6wfgUPoFwWkRUYRjWNgb7L/5QCCqFgVslaWNfSmndCyfGv
         bMRiD8+hLBelSaTTS6UCttxE5uQq2hpIXwu6qeS4e0KXrNe5YXJK0CoGSDImuHm6nL
         UUCNzu4b7UlPvbWTA9n9fibnrxY9+2+Lo4SPMtsZX+zc4EH+lGeqnUNSW/E+stYKlO
         QBY1AaxUZaVeA==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id D238D8061A;
        Wed,  9 Mar 2022 14:51:32 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 0/2] Cleanups for slab
Date:   Wed,  9 Mar 2022 22:50:50 +0800
Message-Id: <20220309145052.219138-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-03-09_05:2022-03-09,2022-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=386 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203090083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

2 cleanups, no functionality changed.

Xiongwei Song (2):
  mm: slab: Delete unused SLAB_DEACTIVATED flag
  mm: slub: Delete useless parameter of alloc_slab_page()

 include/linux/slab.h | 3 ---
 mm/slub.c            | 8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.30.2

