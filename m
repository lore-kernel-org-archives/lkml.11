Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BEC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jun 2022 08:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiFSIhs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 04:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiFSIhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:37:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685C1D71
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F2CB80BA5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6A0C341C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 08:37:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZNCLmUaf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655627859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=teucPwLMI11e8vQBIMGAL5FV6pDQTFgjgjHA80hD2jo=;
        b=ZNCLmUaf0Sz18yVQMEt1MpVUqD4jZiq+ShnWcdhI0oHWp1JrqqG7ZDLrlf/5NtuI3VOKYR
        tiX1EzfLj/vK/F1+NTQCZAnlYCBwGstFM1vgQO9v8/ONInisYQdJ56brjIwLhtMEOu01jF
        Eygn3N5PB6Mq/oEUmDtuMeJao6rPlG4=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3546516b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jun 2022 08:37:39 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3178acf2a92so41051177b3.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 01:37:39 -0700 (PDT)
X-Gm-Message-State: AJIora9ioOkXHa0pQw8s0O0gllcNgLaP5g2ZDXNZSY4Vmn29HLMxcxCl
        q8gTdA8taSQVe0wRAik6D1E8Rqss5H1t3Rvtzmw=
X-Google-Smtp-Source: AGRyM1tReRqCuxX4GpYbFTVqgup0UQ4L4NMW6UqxPCMM3qDulB5wU2AzGdZ/R5YjxJmi38IaHt/M49ATSgPcDqSg5gA=
X-Received: by 2002:a0d:e0c6:0:b0:317:9602:55d1 with SMTP id
 j189-20020a0de0c6000000b00317960255d1mr6618030ywe.2.1655627857621; Sun, 19
 Jun 2022 01:37:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:6407:b0:181:6914:78f6 with HTTP; Sun, 19 Jun 2022
 01:37:36 -0700 (PDT)
In-Reply-To: <f1eb20d1-6762-dc82-058a-cf27936bc0c6@infradead.org>
References: <YqyDqMAPHIxjA/xZ@zx2c4.com> <20220617133847.27517-1-Jason@zx2c4.com>
 <f1eb20d1-6762-dc82-058a-cf27936bc0c6@infradead.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 19 Jun 2022 10:37:36 +0200
X-Gmail-Original-Message-ID: <CAHmME9qH8BfTk26awzEGqn992jZDBXfNCpM7LwRv5GP3kLeeaw@mail.gmail.com>
Message-ID: <CAHmME9qH8BfTk26awzEGqn992jZDBXfNCpM7LwRv5GP3kLeeaw@mail.gmail.com>
Subject: Re: [PATCH] printk: allow direct console printing to be enabled always
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/22, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
> On 6/17/22 06:38, Jason A. Donenfeld wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 8090130b544b..a960c47a2002 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4389,6 +4389,14 @@
>>  	printk.time=	Show timing data prefixed to each printk message line
>>  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>>
>> +	printk.always_direct=
>> +			Rather than using kthreads for printk output, always
>> +			write to the console immediately. This has performance
>> +			implications, but will result in a more faithful
>> +			ordering and interleaving with other processes writing
>> +			to the console.
>> +			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>
> or:
>
> +			Format: <bool>  (1/Y/y/T/t/on=enable, 0/N/n/F/f/off=disable)
>

This is the same as the lines above and below. So I think you'd be
better off sending an independent patch that fixes all of these in one
fell swoop, rather than introducing an inconsistency in this one.

Jason
