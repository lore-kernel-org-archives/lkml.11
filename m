Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8039BC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 20:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiDYUq0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiDYUqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:46:23 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D5E108FD7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP77i016848
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmcsgwjgp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:43:17 -0700
Received: from twshared19572.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 13:43:15 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 4AE8B652E79B; Mon, 25 Apr 2022 13:40:33 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <hch@infradead.org>, <peterz@infradead.org>,
        <torvalds@linux-foundation.org>, Song Liu <song@kernel.org>
Subject: [PATCH bpf v2 0/3] bpf: invalidate unused part of bpf_prog_pack
Date:   Mon, 25 Apr 2022 13:39:44 -0700
Message-ID: <20220425203947.3311308-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 7HqlLmQ9tu3hvdpgACeXAvZBDq3Fa12_
X-Proofpoint-ORIG-GUID: 7HqlLmQ9tu3hvdpgACeXAvZBDq3Fa12_
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: while prefixed with "bpf", this set is based on Linus' master branch.

This is v2 of [1]. It is revised based on Peter's feedback. The patch is
also split into 3.

[1] https://lore.kernel.org/linux-mm/20220421072212.608884-1-song@kernel.org/

Song Liu (3):
  bpf: fill new bpf_prog_pack with illegal instructions
  x86/alternative: introduce text_poke_set
  bpf: introduce bpf_arch_text_invalidate for bpf_prog_pack

 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        | 70 ++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c          |  5 ++
 include/linux/bpf.h                  |  1 +
 kernel/bpf/core.c                    | 18 +++++--
 5 files changed, 81 insertions(+), 14 deletions(-)

--
2.30.2
