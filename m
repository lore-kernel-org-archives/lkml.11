Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B5FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 May 2022 03:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiE2DfF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 May 2022 23:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiE2DfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 23:35:04 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78D8E94
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 20:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653795302; x=1685331302;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dTXXsL+kAGePyp6L3JcHTk8H+hDdvROXrEUyJWDGZ70=;
  b=lPcD0yBVeJX+ZP6klUju2Rzhl3W4nJRmO3NCp+iaEm71a0aCIDvXxGfF
   qODpwKVG1FwIApFpjsVsGOOAWsnRc2YGYipk7f128C8OVj6P98s67sSm2
   30jDTmU2Z5qAhAIbhnQB289kSu6/K2o3Cx6njNs0QYt8eEisyLM5IaPaR
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 May 2022 20:35:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 20:35:02 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:35:01 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 28 May 2022 20:34:59 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH v2 0/2] tracing/probes: allow no event name input when create group
Date:   Sun, 29 May 2022 11:34:52 +0800
Message-ID: <1653795294-19764-1-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

take kprobe event as example, when create a group of events,
p[:[GRP/]EVENT] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS],
according to this format, we must input EVENT name,

this change allow only GRP/ input, EVENT name auto generate from KSYM,
p[:[GRP/][EVENT]] [MOD:]KSYM[+OFFS]|KADDR [FETCHARGS]

siliar change apply to eprobe and uprobe.

V1: https://lore.kernel.org/lkml/1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com/T/#m33b0665941d9caeeb118afa84db4016321cea9a6
V2: fix remove comment in V1 patch1,
    remove v1 patch2 as it is NACK.

Linyu Yuan (2):
  tracing: auto generate event name when create a group of events
  tracing: eprobe: remove duplicate is_good_name() operation

 Documentation/trace/kprobetrace.rst  |  8 ++++----
 Documentation/trace/uprobetracer.rst |  8 ++++----
 kernel/trace/trace_dynevent.c        |  2 +-
 kernel/trace/trace_eprobe.c          | 24 ++++++++++++------------
 kernel/trace/trace_kprobe.c          | 19 ++++++++++++-------
 kernel/trace/trace_probe.c           |  9 ++++++++-
 kernel/trace/trace_probe.h           |  4 ++++
 kernel/trace/trace_uprobe.c          | 15 ++++++++++-----
 8 files changed, 55 insertions(+), 34 deletions(-)

-- 
2.7.4

