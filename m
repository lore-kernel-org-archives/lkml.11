Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58801C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 06:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243311AbiC3GaV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiC3GaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:30:18 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240655227
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b15so23192994edn.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jeyVjUl8UxMsfAwAWYqgKhKVc6qpMwqWakUeuaih7vk=;
        b=tH4KpeMCj1g/eVF2kz2mtjnwDDoDdq4u6CLDQFszL7FihldHG5vOhIz/a7r/h58KI3
         /Bo9cKFscNeko7YLiHVLzJiy93kkTYhdaDZKeH/IfW+Q9i4GBBYawph65BrFSzAGyKq2
         1oxCLCRUfZ4/iVDlb5yTMiVb4XhOT5Q+EAZSNnoQHuQ1Nbw8AApsZJZ9kCTtrA8KFtpp
         5rJgyk1+LDGOW+dH321nzvD2PZ8CJ9/gK8yk5ST+LZzVKLo5Oga/xzIhnSn/7abEyuMC
         fQEIqCMIyTOGCF0uoziBAP/g9niKcUJNwFUaZYWzIL8fdtWovxqYDDgrrQh/cDW14eOY
         8pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeyVjUl8UxMsfAwAWYqgKhKVc6qpMwqWakUeuaih7vk=;
        b=acYCdLY6rpNiuYxFmdTyBBD7V0LFEWyH/FlXhDSAPOROi+Z7oUW0ONhAgeFGGVb4Wr
         7lEUK+oeQqzO3kGI2aSFSuwgR32v4G0jSuPzzQ+nuzmhVgSvShbl9at/cxkUny1SIlsv
         MCv36r96RxD8kKCFiSTI9k2LOZ5cQ7eXFQTfvsH72/76g9qy+W24KWlJ0Afs0o+5YoqA
         sTKUJAzP5Xh+arqfasYyt4O8v72vwHbWVydotuvYialz1ZR7+DuExxZ9mUhXblxYcySw
         EEaw/iEjqNbAW7oQjDt7PqWJ3YSnIqkpIISVGyxGZHepeTFoTxj7A33nCtbW5hY/NhMP
         734g==
X-Gm-Message-State: AOAM532Ay4AWoPuHa64rSNnLZfDl7uHz04CAmgLSGv9i97YiqOX/08jh
        tmk005ZiquFWiv+7t2F3SS3+Alu+YGkvLMwWeVd2PA==
X-Google-Smtp-Source: ABdhPJzvYAlNbp3AlnGzDTBeNPyTBGecgDc9rfpmjaE3Gzlb2cCIAIeQJFdlTi48g0Ioj91H5O7A4of4kv2EPxgl2xU=
X-Received: by 2002:a05:6402:43cc:b0:419:2486:6cd2 with SMTP id
 p12-20020a05640243cc00b0041924866cd2mr8817467edc.334.1648621703622; Tue, 29
 Mar 2022 23:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220329214248.1330868-1-dlatypov@google.com> <CABVgOS=r1HhBRjKmb6RE9MLbxD3TLfOxvATXH-qLHnr9yjO35g@mail.gmail.com>
In-Reply-To: <CABVgOS=r1HhBRjKmb6RE9MLbxD3TLfOxvATXH-qLHnr9yjO35g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 30 Mar 2022 01:28:12 -0500
Message-ID: <CAGS_qxoYJTt-++EGQ23h_FwjrHKfnBbFVivM9gTXZg=0kh57og@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: print clearer error message when there's no
 TAP output
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 10:17 PM David Gow <davidgow@google.com> wrote:
>
> On Wed, Mar 30, 2022 at 5:43 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Before:
> > $ ./tools/testing/kunit/kunit.py parse /dev/null
> > ...
> > [ERROR] Test : invalid KTAP input!
> >
> > After:
> > $ ./tools/testing/kunit/kunit.py parse /dev/null
> > ...
> > [ERROR] Test <missing>: could not find any KTAP output!
> >
> > This error message gets printed out when extract_tap_output() yielded no
> > lines. So while it could be because of malformed KTAP output from KUnit,
> > it could also be due to to not having any KTAP output at all.
> >
> > Try and make the error message here more clear.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> At first I thought that this was "working as intended", but I agree
> that it's a bit confusing, so changing it is for the best.
> (And there's no sense getting too bogged down in the philosophical
> difference between "invalid TAP" and "not valid TAP" :-))

extract_tap_output() returning something means it just saw a TAP header.
So this error realistically only happens when there's no TAP at all :P

My allusion to malformed KTAP is in the sense that
 KTA<random stuff>P ver<more stuff>sion 1
is malformed.

We could potentially be more completely precise w/ our error message
and say "no K?TAP header found", but I initially thought this might be
a bit more user-friendly.
