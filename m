Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7979EC433FE
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 21:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355943AbiDDVUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380494AbiDDUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:19:53 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB6E33EB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:17:56 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-df22f50e0cso12112970fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nEvcII0ovuM4EzEotmtCSIUih83HD7CSYw1Kvs+WzIU=;
        b=DNx1sG4uPUCc9NNECa/VtJQv3bn+9r5mWeFUqZuhgqr22wHPeG4YWrVwltutzc6xTT
         Ld6bfJhKBW69G7FjflRdszEome3zN6HKxJzUkW4pnIvoR/7P1G72IywwhiYnot96Huir
         coB4Vou6i38DNyzwwrvTuEf21xWIpkcVZiVDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nEvcII0ovuM4EzEotmtCSIUih83HD7CSYw1Kvs+WzIU=;
        b=4DSV9KmZINT8D6Fhu7GBnwZcRb2/NSGC2OvrY3uL/fftOW5qqE/5QBgKUdG3eqMJCD
         giI/SRXKccDcrcNrdSjBZSHLi3GsQ7U2NltlpOcKNQLps5LpezDd3aVAkrBPpsCBUbyG
         04POC3SEvFZ8dLFtM7Os2mJPrk2JOdneUFwiEno1ADC6hyusYrhX+N5IsFPRfXCtQC/B
         1tHI1ANNmejSHLuWVShZy8z8+shfmBhaxeV4iN2+2ZR7m3aLIxHVwpDCtWsh6JJgeL9l
         u5smlH4gViGcYuDESqyFeHewgd9gMt2XFSI96KNUs5kgnM1N0dVOTTVlRAIgn6/Xgd4I
         bvrg==
X-Gm-Message-State: AOAM530wLSCztz1mTGVPTmqNyYeOfDHH9/tgscg73VFIazCOUsrbd0KH
        ZpcjbfPgAfjwQWnhY7pzhPa2JL8+0iWG2cxr
X-Google-Smtp-Source: ABdhPJy1YASaOHaUF4GOT3ncSWR8x+K6ei6LQgfbD/4/uRe89U3T65lKldkMBMKGA9E3uchldp5AzQ==
X-Received: by 2002:a05:6870:c10b:b0:da:40b:9d92 with SMTP id f11-20020a056870c10b00b000da040b9d92mr517126oad.31.1649103476013;
        Mon, 04 Apr 2022 13:17:56 -0700 (PDT)
Received: from [192.168.86.32] (71-218-50-127.hlrn.qwest.net. [71.218.50.127])
        by smtp.gmail.com with ESMTPSA id m38-20020a056870562600b000e1f4a4ed9dsm2067908oao.51.2022.04.04.13.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 13:17:55 -0700 (PDT)
Message-ID: <51b21470-cd72-7ae3-6f33-2dd2e1d6b716@chromium.org>
Date:   Mon, 4 Apr 2022 16:17:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
 <20220316210341.GD14330@worktop.programming.kicks-ass.net>
 <20220321133037.7d0d0c7f@gandalf.local.home>
 <20220329172236.48683eb5@gandalf.local.home>
From:   "T.J. Alumbaugh" <talumbau@chromium.org>
In-Reply-To: <20220329172236.48683eb5@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/29/22 17:22, Steven Rostedt wrote:
> On Mon, 21 Mar 2022 13:30:37 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Wed, 16 Mar 2022 22:03:41 +0100
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>
>>> Does something like the below (untested in the extreme) help?
>> Hi Peter,
>>
>> This has been tested extensively by the ChromeOS team and said that it does
>> appear to fix the problem.
>>
>> Could you get this into mainline, and tag it for stable so that it can be
>> backported to the appropriate stable releases?
>>
>> Thanks for the fix!
>>
> Hi Peter,
>
> I just don't want you to forget about this :-)
>
> -- Steve
>
Hi Peter,

Just a note that if/when you send this out as a patch, feel free to add:

Tested-by: T.J. Alumbaugh <talumbau@chromium.org>

Thanks,

- T.J.

