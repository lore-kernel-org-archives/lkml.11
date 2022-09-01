Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F53AECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 00:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiIAAGv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiIAAGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:06:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAD5E116D;
        Wed, 31 Aug 2022 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661990806; x=1693526806;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=wBCLAwrJD3CoNKwwccz6dz0/r9Pa/erMe9NtEN4fRG4=;
  b=DETrs/VudlaCcoJhaaPwIPvGtTGH75QUPGJnb9GqhJm1rSVT7ytTg0vJ
   ObiR9jxie1LXn6w0ByqA4jGP0kBeUjFtBhxkZqNkG0r4ZrBHC+gv93U3s
   Z28sJQHu2doiTbzP4N9WPwGDMvQ+e89bkO6jJM7kgcSXprertLM2YXsJD
   +4G4UYDMSr933nR+2nY/uGQ7szQKRNkYKaQMbIKadVQT4AYpFrAd7hdCJ
   uHIMBw+a7chDfsrDp6h2zMto2GWiZZ3R8EXU+iqdxUv9cbrDUbIRZfay3
   /1V1AFR7tniqiUoK5XH111XeDaZh2DLPAxwOL2XSqCl/8EzcjDFUAXu7e
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="359539345"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="359539345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 17:06:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="612283388"
Received: from jholm-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.119.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 17:06:45 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc:     weiyongjun1@huawei.com, yuehaibing@huawei.com,
        shaozhengchao@huawei.com
Subject: Re: [PATCH net-next] net: sched: etf: remove true check in
 etf_enable_offload()
In-Reply-To: <20220831092919.146149-1-shaozhengchao@huawei.com>
References: <20220831092919.146149-1-shaozhengchao@huawei.com>
Date:   Wed, 31 Aug 2022 17:06:45 -0700
Message-ID: <87wnaohsa2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhengchao Shao <shaozhengchao@huawei.com> writes:

> etf_enable_offload() is only called when q->offload is false in
> etf_init(). So remove true check in etf_enable_offload().
>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
