Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C073AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 06:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbiBOGco (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:32:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiBOGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:32:40 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD666AB441
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:32:30 -0800 (PST)
X-QQ-mid: bizesmtp16t1644906739tc1dkgvw
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 14:32:14 +0800 (CST)
X-QQ-SSF: 0140000000200030C000C00A0000000
X-QQ-FEAT: SAUrQiVpIXGLggNbsPntDsJ4nG5O1pBTVtjhVw2VlwEER9OI9kWUKj/jaTTMp
        rL3U5XXomyE2/VUCku1dfc+Vfaw5SXcE8pXMNirnITMS7PoE7vfU6X9eHR7rOD+F4MH72C/
        U5NyNGSvj04FdAbtcySxKZebugONjya9OsOvkDaOFf+Hddhq5ozwrHOhrx+aOICx52VL3hs
        ThO58P6wEBtO7724npiPhXu0Jdr4Osglq+YlAubkBLQK3iAwZroifKV0hUEf34nXxCiGbiA
        LSerfsucQpBcJl6RsOjF0A6dm20qqGmeZyPPp9VOldNx9fCCgR+FhAMx8PJ+2SFo5jmL1Fa
        3wrfYjQjnN6hedDR0D++K6A4YrsUiF/4BXWYMK5
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH v2 0/8] sched: Move a series of sysctls starting with sys/kernel/sched_*
Date:   Tue, 15 Feb 2022 14:32:06 +0800
Message-Id: <20220215063206.22691-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move a series of sysctls starting with sys/kernel/sched_* and use the
new register_sysctl_init() to register the sysctl interface.

Zhen Ni (8):
  sched: Move child_runs_first sysctls to fair.c
  sched: Move schedstats sysctls to core.c
  sched: Move rt_period/runtime sysctls to rt.c
  sched: Move deadline_period sysctls to deadline.c
  sched: Move rr_timeslice sysctls to rt.c
  sched: Move uclamp_util sysctls to core.c
  sched: Move cfs_bandwidth_slice sysctls to fair.c
  sched: Move energy_aware sysctls to topology.c

 include/linux/sched/sysctl.h | 41 ---------------
 kernel/sched/core.c          | 69 ++++++++++++++++++-------
 kernel/sched/deadline.c      | 42 +++++++++++++---
 kernel/sched/fair.c          | 32 +++++++++++-
 kernel/sched/rt.c            | 56 +++++++++++++++++++--
 kernel/sched/sched.h         |  7 +++
 kernel/sched/topology.c      | 25 +++++++++-
 kernel/sysctl.c              | 97 ------------------------------------
 8 files changed, 199 insertions(+), 170 deletions(-)

-- 
2.20.1



