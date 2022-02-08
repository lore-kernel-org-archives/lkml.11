Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE51AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 13:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiBHN05 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359186AbiBHNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:25:45 -0500
X-Greylist: delayed 2520 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 05:19:28 PST
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A32C004386
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:19:28 -0800 (PST)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 218CbD4m058607;
        Tue, 8 Feb 2022 21:37:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Tue, 08 Feb 2022 21:37:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 218CbCsG058604
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Feb 2022 21:37:12 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5a65fe57-70ce-68c1-6578-5545b1af9392@I-love.SAKURA.ne.jp>
Date:   Tue, 8 Feb 2022 21:37:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: regression: LTP isofs testcase failure - bisection fingers "loop:
 make autoclear operation asynchronous"
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <4eb771d2b48ee94ba2e3aa8706bce8117d398e80.camel@gmx.de>
 <c53285e4-cbd4-5fd0-cbc9-93e2e3d3d88d@I-love.SAKURA.ne.jp>
 <83f59bac8286f3348d4c7ccdd93d1ce1ad2f06c9.camel@gmx.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <83f59bac8286f3348d4c7ccdd93d1ce1ad2f06c9.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/08 12:16, Mike Galbraith wrote:
> On Tue, 2022-01-18 at 06:57 +0900, Tetsuo Handa wrote:
>> On 2022/01/18 0:34, Mike Galbraith wrote:
>>> Greetings,
>>>
>>> LTP's isofs testcase began failing this cycle, and bisected as below,
>>> which a revert then confirmed.  Full testcase output attached.
>>>
>>
>> Thanks for reporting.
>> Discussion is continued at https://lkml.kernel.org/r/cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp .
> 
> <legalese-disclaimer-font> ping
> 

Still waiting for response. It seems that we are unable to come to a conclusion.
