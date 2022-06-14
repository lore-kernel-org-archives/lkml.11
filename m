Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28BC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 01:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348779AbiFNBsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 21:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbiFNBs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:48:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63C2AE33;
        Mon, 13 Jun 2022 18:48:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C809CE1763;
        Tue, 14 Jun 2022 01:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C7EC3411E;
        Tue, 14 Jun 2022 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655171303;
        bh=kHVpMpq++uoILG8nEpsnJIRDObfNN0ura8aEr/40J5g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PHLniVGe96eCVgQd6i8SCb2VQ8SV2TbyBAvvsjPqz+jBf0JxbnHKYBXaBJgAin57x
         l23HXLkgQiLI1XRR9uTlcpitTheTlSWA01VSo/6F8MU/7SbitF6DvTOJW16KsjlUZr
         L2SATQZ6jbpEzm53tWAXBk48vhfthzhWfSfQiubKyxynPTycF5CwGEZyuQYSHlh+dY
         dpfuZXLECuvU6XTTZPJvUW/SZxr96ZaNDzeDzRdEB/iANHSDdEnoj8RljdoauDMEe6
         Vxzdc+FvG3dCMN9lcfhmc5tXsxxJzw++7El1+Vbm4pv3JmQKOAg/Y5xkMOzskV7SuF
         yaZRfrhieTW3Q==
Message-ID: <1544ed72-0865-6cff-e9fa-02a1eb1ed50d@kernel.org>
Date:   Tue, 14 Jun 2022 09:48:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] docs: filesystems: f2fs: fix description about
 compress ioctl
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Chao Liu <chaoliu719@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220613020800.3379482-1-chaoliu719@gmail.com>
 <Yqaw3VTD46PAMN8O@casper.infradead.org> <Yqbu+BArbUNGvft9@liuchao-VM>
 <87czfc1nr8.fsf@meer.lwn.net>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <87czfc1nr8.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 1:23, Jonathan Corbet wrote:
> Chao Liu <chaoliu719@gmail.com> writes:
> 
>> On Mon, Jun 13, 2022 at 04:37:01AM +0100, Matthew Wilcox wrote:
>>> On Mon, Jun 13, 2022 at 10:08:00AM +0800, Chao Liu wrote:
>>>> v2:
>>>> - s/file size/filesize/
>>>
>>> Why would you change it to be wrong?
>>>
>>
>> This is a suggestion from Chao Yu. Maybe he has some other considerations.
> 
> Sorry, I should have replied to that.  I disagree with that suggestion.
> "Filesize" is not an English word, and there doesn't seem to be any
> reason to use it in our docs.

My bad, out of mind at that time, sorry for my wrong suggestion...

> 
> <checks>
> 
> We have to occurrences now - one already in the f2fs docs.  I think we
> shouldn't add more.  So my plan is to apply the first version of this
> patch.  Chao Liu: is there a reason why you didn't add the Reviewed-by
> from Chao Yu in the second version?  Chao Yu: is that tag still
> applicable even without the "filesize" change?

Yes.

Thanks,

> 
> Thanks,
> 
> jon
