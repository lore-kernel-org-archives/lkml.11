Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2462C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 00:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiCVAY4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiCVAYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:24:51 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD21788DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647908589; x=1679444589;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zDlH0ZClt/l8kXY2KRvl+K26irE1q1spi3F8nlx8XRg=;
  b=TSUB2ndSr4VshqPAjySci3mdIDJuIvzW9JrLn4h0JTiZiK3uXyeyqLIL
   azmYuGTWTXOVR3NDI5y3c9+IQy7tZZgNJ2Md8agH9E4ac0MwFQw5CZGRr
   I5a/zhjC3Wh16KrPCK+u55FVW5L2Xzn1hNqnqCrtIjjKyO44FDWTiqzAJ
   wGTEWVQt4Hk26PWp/wgJAgjUPqrPmtTaI0nQLQcqqwwJw/jskTQ0pmp/L
   +qCqZfBNZaWg3vme/N64Aqvp0KfTs/QQN+H5Xw06TD0whDK/EOadmLRgo
   mZ7KpY5Y5nsGSLDqIRzeyyWL4Fe1Nbed6YVPvHW4wPZBSucKn27xmqbDw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="344111434"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="344111434"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="500364874"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.227.186])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:22:32 -0700
Message-ID: <a19be99d1e1a282bd5c6b9af60ea6c0417223000.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] sched/core: Propagate parent task's latency
 requirements to the child task
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com
Date:   Mon, 21 Mar 2022 17:22:32 -0700
In-Reply-To: <20220311161406.23497-3-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
         <20220311161406.23497-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-11 at 17:14 +0100, Vincent Guittot wrote:
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  init/init_task.c    | 1 +
>  kernel/sched/core.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/init/init_task.c b/init/init_task.c
> index 73cc8f03511a..2afa249c253b 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -78,6 +78,7 @@ struct task_struct init_task
>  	.prio		= MAX_PRIO - 20,
>  	.static_prio	= MAX_PRIO - 20,
>  	.normal_prio	= MAX_PRIO - 20,
> +	.latency_nice	= 0,

Probably better to use non hardcoded number here
	.latency_nice   = DEFAULT_LATENCY_NICE;

>  	.policy		= SCHED_NORMAL,
>  	.cpus_ptr	= &init_task.cpus_mask,
>  	.user_cpus_ptr	= NULL,
> 

Tim

