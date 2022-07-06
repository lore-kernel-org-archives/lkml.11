Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25530C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 03:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiGFDlB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 23:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGFDk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:40:59 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1814CE2F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657078857; x=1688614857;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ng7CSDopvWN54bb8Chqd6ayCiZeMtBjP9nwzGkPi98o=;
  b=XWdq/pGoY93bkrai+7FiEYvQ9p/Vbbnz7QhQ3yhKzLa9ghdtEAOCOzFy
   8A5oT7TKriYInXyI0/F9tUhEMxpqItJJqOsdZY2bm2wB50NG25EUg4/yY
   jHVB6wcgHqv4MJHoWYq0fyuT1Yf06C5aG2s+UKT8NNUQGdl0l4YIbwDTS
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 20:40:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:40:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 20:40:56 -0700
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 20:40:55 -0700
Subject: Re: [PATCH] sched: fix rq lock recursion issue
To:     Peter Zijlstra <peterz@infradead.org>
CC:     'Steven Rostedt' <rostedt@goodmis.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20220624074240.13108-1-quic_satyap@quicinc.com>
 <Yr4lkBjU6Dy6Wb57@home.goodmis.org>
 <000101d89013$f2157320$d6405960$@quicinc.com>
 <YsPnH1K+K8f3Qp4e@hirez.programming.kicks-ass.net>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <ee1dbc8a-2615-727a-65d3-736c3086953f@quicinc.com>
Date:   Tue, 5 Jul 2022 20:40:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YsPnH1K+K8f3Qp4e@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/5/22 12:24 AM, Peter Zijlstra wrote:
>
> Please, burn outlook and use a real MUA, this is unreadable garbage.
Yes, I shall. Sorry about that.
