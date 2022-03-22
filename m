Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D72C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 16:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiCVQsJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiCVQsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:48:06 -0400
Received: from smtp97.iad3b.emailsrvr.com (smtp97.iad3b.emailsrvr.com [146.20.161.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C422AE3C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1647967597;
        bh=lnsLWwckfIuoyYKT/hgu3JJEBeyOBkDTPZJpLBT8C+M=;
        h=Date:Subject:To:From:From;
        b=VfkvClOTCUq3Y1LKtHgC4E6ndJy4fmzCaCgCH56GUyrbJ+u5nXxvKscgPqxprqSCt
         ZBjl4rXcAod+m1dubh/q2szhAOmvxm8PMT9q1qSY/2YpN2N6cOL2KAxLkTn3g1dAI/
         nd5KDMF7YPeyz0auBfRoz70NLn0U4jSGWNassPAY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp13.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BA7D16016B;
        Tue, 22 Mar 2022 12:46:36 -0400 (EDT)
Message-ID: <e62cb512-c17e-b470-a547-23c0f75e9220@mev.co.uk>
Date:   Tue, 22 Mar 2022 16:46:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ioctl_userfaultfd.2: Corrections for returned .ioctls
 members
Content-Language: en-GB
To:     Axel Rasmussen <axelrasmussen@google.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220318191343.72812-1-abbotti@mev.co.uk>
 <YjgW7L77+Y2fylcR@xz-m1.local>
 <a2380fac-d173-50e3-963a-d7fc22b2da5d@gmail.com>
 <CAJHvVch=vO6gwyn+swyeHEQ4mUccL6T+Vt3G9akeEjXZ6XKM-A@mail.gmail.com>
 <CAJHvVchqALH-0Y8LgkqAFnwbfEjkheNTKhpSeUMY2d+bU44tGg@mail.gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <CAJHvVchqALH-0Y8LgkqAFnwbfEjkheNTKhpSeUMY2d+bU44tGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 675f08a2-e9f2-4e2a-979d-0e3ef20eac7e-1-1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 16:36, Axel Rasmussen wrote:
> On Tue, Mar 22, 2022 at 9:23 AM Axel Rasmussen <axelrasmussen@google.com> wrote:
>>
>> On Tue, Mar 22, 2022 at 5:32 AM Alejandro Colomar (man-pages)
>> <alx.manpages@gmail.com> wrote:
>>>
>>> Hi Ian and Peter,
>>>
>>> On 3/21/22 07:10, Peter Xu wrote:
>>>> On Fri, Mar 18, 2022 at 07:13:43PM +0000, Ian Abbott wrote:
>>>>> Support for the `UFFDIO_WRITEPROTECT` operation is not indicated in the
>>>>> `ioctls` member of `struct uffdio_api`.  It is indicated in the `ioctls`
>>>>> member of `struct uffdio_register` along with indications of support for
>>>>> the `UFFDIO_COPY`, `UFFDIO_WAKE` and `UFFDIO_ZEROPAGE` operations (and
>>>>> also the `UFFDIO_CONTINUE` operation supported since Linux 5.13 but
>>>>> that is not documented by this man page yet.)
>>>>
>>>> I thought it should have landed but indeed it's not.  Copying Axel.
>>
>> Ah, I mistakenly thought it got merged, but there were a few remaining
>> issues Alejandro wanted addressed first. I'll send a v3 of it later
>> today.
>>
>> For what it's worth, as part of adding minor fault handling, we pretty
>> significantly change the ioctl field's behavior, and I rewrote a lot
>> of the documentation around it. So, it may conflict with this patch.
>> :/ Sorry about that.
> 
> Heh, I spoke too soon. My patch doesn't touch this after all, I think
> the patches don't conflict. :) It's been a while since I looked at
> it...

I guess the section (in my patch) that indicates supported ioctls in 
`struct uffdio_register` would still need tweaking to mention 
`UFFDIO_CONTINUE` though, so either one of the patches will need to 
change or another little patch will be needed.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
