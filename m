Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821D4C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiGKWEe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 18:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiGKWEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 18:04:32 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602C509F8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 15:04:31 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59882)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1W2-006u22-Jr; Mon, 11 Jul 2022 16:04:30 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:46748 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oB1W1-00H0EA-J3; Mon, 11 Jul 2022 16:04:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <YrslT9h0whngMIhw@zx2c4.com>
        <20220628161441.892925-1-Jason@zx2c4.com> <YsLbggVXONPJcZsn@zx2c4.com>
        <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
        <87o7xvcw98.fsf@email.froward.int.ebiederm.org>
        <YsyFhfAunVfVQKci@zx2c4.com>
Date:   Mon, 11 Jul 2022 17:04:22 -0500
In-Reply-To: <YsyFhfAunVfVQKci@zx2c4.com> (Jason A. Donenfeld's message of
        "Mon, 11 Jul 2022 22:18:13 +0200")
Message-ID: <87pmib9uhl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oB1W1-00H0EA-J3;;;mid=<87pmib9uhl.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/1HTqajhPT84+ODD85nv77lVNjH4ulgdI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3] signal: break out of wait loops on kthread_stop()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:

> Hi Eric,
>
> Thanks for the review.
>
>> Which I guess my long way of saying I think you can just change
>> kthread_stop to say:
>> 
>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 544fd4097406..52e9b3432496 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
>>  	kthread = to_kthread(k);
>>  	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>>  	kthread_unpark(k);
>> +	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>>  	wake_up_process(k);
>>  	wait_for_completion(&kthread->exited);
>>  	ret = kthread->result;
>> 
>
> Okay. I'll constrain it to just kthread_stop(). But please file away in
> the back of your mind the potential for kthread_park() to be problematic
> down the line, in case we have to fix that later.

Definitely.  Right now I am certain you are motivated to test and make
certain the kthread_stop case will work.  I just have the feeling that
we don't care enough about kthread_park, and so attempting to solve it
now is as likely to cause problems as solve them.

Eric
