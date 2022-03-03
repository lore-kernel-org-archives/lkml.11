Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5F2C4332F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 09:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiCCJpK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 04:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiCCJpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:45:09 -0500
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96D178695;
        Thu,  3 Mar 2022 01:44:23 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V66rSXQ_1646300660;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V66rSXQ_1646300660)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Mar 2022 17:44:20 +0800
Date:   Thu, 3 Mar 2022 17:44:19 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20220303094419.GB35207@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20220303201352.43ea21a3@canb.auug.org.au>
 <20220303201536.042e9135@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303201536.042e9135@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 08:15:36PM +1100, Stephen Rothwell wrote:
>Hi all,
>
>On Thu, 3 Mar 2022 20:13:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the net-next tree, today's linux-next build (htmldocs)
>> produced this warning:
>> 
>> Documentation/networking/smc-sysctl.rst:3: WARNING: Title overline too short.
>> 
>> =========
>> SMC Sysctl
>> =========
>> 
>> Introduced by commit
>> 
>>   12bbb0d163a9 ("net/smc: add sysctl for autocorking")
>
>Also:
>
>Documentation/networking/smc-sysctl.rst: WARNING: document isn't included in any toctree

Thanks for your reminder ! I'll send a patch to fix this warnings soon.

