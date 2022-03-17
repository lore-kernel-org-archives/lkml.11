Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiCQW0q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 18:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCQW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:26:43 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12023455A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:25:25 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22HMP86Y092082;
        Fri, 18 Mar 2022 07:25:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 18 Mar 2022 07:25:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22HMP7Bj092075
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 18 Mar 2022 07:25:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d1ed2184-00ee-9756-5ad2-7c8189634748@I-love.SAKURA.ne.jp>
Date:   Fri, 18 Mar 2022 07:25:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3] workqueue: Warn flushing of kernel-global workqueues
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, kernel test robot <oliver.sang@intel.com>
References: <20220221083358.GC835@xsang-OptiPlex-9020>
 <3a20c799-c18e-dd3a-3161-fee6bca1491e@I-love.SAKURA.ne.jp>
 <YhUdjip4VSWe4zDO@slm.duckdns.org>
 <16a33a65-3c67-ef66-ccc8-9c4fffb0ae5a@I-love.SAKURA.ne.jp>
 <YhaoDiJ8MUOhRmp6@slm.duckdns.org>
 <9a883d72-ea7d-1936-93e6-5c2a290509d4@I-love.SAKURA.ne.jp>
 <Yha1LeX4OK3cLCV5@slm.duckdns.org>
 <4165db50-1365-549a-eb77-6122c78d4814@I-love.SAKURA.ne.jp>
 <Yh0XmUtuuyaO9j8j@slm.duckdns.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Yh0XmUtuuyaO9j8j@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/03/01 3:42, Tejun Heo wrote:
> On Mon, Feb 28, 2022 at 11:03:47PM +0900, Tetsuo Handa wrote:
>> Then, what about this?
>> If this looks OK, I'll test this patch using linux-next via my tree.
> 
> Yeah, looks good to me. Can you boot test and fix the obvious ones before
> the pushing it to linux-next? It probably would be best if this is kept in a
> separate branch together with all the fix-up patches. Once things settle
> enough, we should be able to route the patches through the wq tree to Linus.
> 
> Thank you so much for doing this.
> 

This patch has been in linux-next.git as commit b9c20da356db1b39 ("workqueue:
Warn flushing of kernel-global workqueues") since next-20220301, and I got no
failure reports. I think we can send this patch to linux.git in order to let
each module's developers to write their patches. (I will drop this patch from
my tree when you pick up this patch.)
