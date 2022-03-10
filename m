Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiCJOJK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiCJOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:09:08 -0500
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EAB403C2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1646921286; bh=TtQs/4k1eRZm3P/NLDMyWBIr6YFOH62OKfNbu4V2HSc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=0ee7vQXdeIcvCvlQJN2RNfRE02VyJ6jShvr5Gt61F3QlyBkfXlp6dA4DHoHNrm6M0
         uaGFqIVY1DLvF8IAagYkC0M1p5L037RHZ/lC2p4pL8QJJgkckMiv0pusyiYU4UBK71
         wLUHteeK45ZAasAg1hj1zPVjLU1jhn1hkXTIzWNYglRLmtpoFRaw//DiMmk592sViO
         TmIs8LSHpPaQRICtnr4zcLfOWneR+YP7Al3TBX1fYbusd9vZSSrhxkfVKUkiX5Y8tn
         ENNxxG0WrEeIXbDxonS3ODyf/m60Vp90uPmWov71fkZisaYdTfjChjEa1UEJ5v+pOV
         zaJ+EO2TL+Kqw==
Received: from xiongwei.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id DBEF680581;
        Thu, 10 Mar 2022 14:07:53 +0000 (UTC)
From:   sxwjean@me.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        longman@redhat.com, guro@fb.com, willy@infradead.org,
        roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 0/2] Cleanups for slab
Date:   Thu, 10 Mar 2022 22:06:59 +0800
Message-Id: <20220310140701.87908-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-03-10_03:2022-03-09,2022-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=380 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2203100077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

2 cleanups, no functionality changed.

---
Since v2:
 - Add the detailed history of parameter @s of alloc_slab_page(),
   message from Matthew Wilcox.
 - Collect Reviewed-by and Acked-by. Thanks Matthew Wilcox, David Rientjes
   and Roman Gushchin.

Since v1:
 - https://lore.kernel.org/all/20220309145052.219138-1-sxwjean@me.com/
---

Xiongwei Song (2):
  mm: slab: Delete unused SLAB_DEACTIVATED flag
  mm: slub: Delete useless parameter of alloc_slab_page()

 include/linux/slab.h | 3 ---
 mm/slub.c            | 8 ++++----
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.30.2

