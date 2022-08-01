Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB642C19F29
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 07:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiHAH3f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 03:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHAH3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 03:29:32 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992102F3B4;
        Mon,  1 Aug 2022 00:29:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VL2sB7a_1659338957;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VL2sB7a_1659338957)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 15:29:26 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 5.10 0/3] fix build error in bpf selftests
Date:   Mon,  1 Aug 2022 15:29:13 +0800
Message-Id: <20220801072916.29586-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a compile error when building tools/testing/selftests/bpf/ on 5.10.y.
tools/testing/selftests/bpf/prog_tests/sk_lookup.c:1092:15: error: 'struct bpf_sk_lookup' has no member named 'cookie'
 1092 |  if (CHECK(ctx.cookie == 0, "ctx.cookie", "no socket selected\n"))
      |               ^

To fix this bug, this patchset backports three patches from upstream:
https://lore.kernel.org/bpf/20210303101816.36774-1-lmb@cloudflare.com/

Patch 1 and 2 are necessary for bpf selftests build pass on 5.10.y.
Patch 3 does not impact building stage, but can avoid a test case
failure (by skipping it).

Lorenz Bauer (3):
  bpf: Consolidate shared test timing code
  bpf: Add PROG_TEST_RUN support for sk_lookup programs
  selftests: bpf: Don't run sk_lookup in verifier tests

 include/linux/bpf.h                           |  10 +
 include/uapi/linux/bpf.h                      |   5 +-
 net/bpf/test_run.c                            | 243 +++++++++++++-----
 net/core/filter.c                             |   1 +
 tools/include/uapi/linux/bpf.h                |   5 +-
 tools/testing/selftests/bpf/test_verifier.c   |   4 +-
 .../selftests/bpf/verifier/ctx_sk_lookup.c    |   1 +
 7 files changed, 204 insertions(+), 65 deletions(-)

-- 
2.27.0

