Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F807C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 06:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbiBOGWb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 01:22:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiBOGW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:22:29 -0500
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8441D0492
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:22:19 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JrE4noUgHi9Q8JrE5nCLGl; Tue, 15 Feb 2022 07:22:17 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 15 Feb 2022 07:22:17 +0100
X-ME-IP: 90.126.236.122
Message-ID: <183f319e-613d-5318-25b2-2c90ef4fdee5@wanadoo.fr>
Date:   Tue, 15 Feb 2022 07:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220215033632.104124-1-jiapeng.chong@linux.alibaba.com>
 <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220215035506.GA1663897@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/02/2022 à 04:55, Keith Busch a écrit :
> On Tue, Feb 15, 2022 at 11:36:32AM +0800, Jiapeng Chong wrote:
>> The error code is missing in this code scenario, add the error code
>> '-EINVAL' to the return value 'ret'.
>>
>> Eliminate the follow smatch warning:
>>
>> drivers/nvme/host/core.c:780 nvme_configure_directives() warn: missing
>> error code 'ret'.
> 
> Nak, the code is correct as-is, just like it was the previous time you
> posted this patch:
> 
>    http://lists.infradead.org/pipermail/linux-nvme/2021-September/027339.html
> 

Hi,

maybe an explicit 'ret = 0;' (and eventually a comment saying why) would 
help here?

The code really looks like an error handling path (and will keep getting 
some patches for it because of bots).

Just my 2c.

CJ
