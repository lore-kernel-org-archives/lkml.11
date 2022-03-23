Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F0FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiCWHlI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiCWHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:41:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B87306D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:39:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so1089881ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEh0/flcESvnwCkKqqvAysliWpY0z2CXDkNX2AVoqs0=;
        b=OoKtuc/vUxOsJQZnoz312bkwh6oBQMglt1+NbBFzszTLeN5kzK9XXHeDjWNKsQlPlY
         hqeHE+aHsGQONYWD0+3cExe+fUkOud9BzoG8YsuH5UgTgLGFS6xrySZygHX7lgRBjIfJ
         dzApgShtqtlWRmYTbTg48Vwu6u+4zLLVaDNj3gjRc33WzXk/EC96UrrdDB+ixWxFPlnt
         IvfAebCXrTPaAKWBYG+Jyfg19ni5YtyFeZFT2622xnX/1KkPNEj+Cl0MXns4bMG/xYh9
         zqwMJodiB/USMjWmQAKNAMOSHaSO4BoyXYP6vzaJZmeaMV5abpWg5ge/jmCOtROYt0Ko
         beuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEh0/flcESvnwCkKqqvAysliWpY0z2CXDkNX2AVoqs0=;
        b=zQV3P+7ERDMy3waNjTmrSCkeAYMT7mTIZa8Onaiy5lQ4ajLsPqRXdsCzkBWUxcVwik
         Ztv7+eCI+J1/AIAp1L/1E+WG9IW1S09uCrvCXde9G6GIysmgPhGzw0F+RPkJ4MWYkFie
         aBeBlwQHVQCdQ1tXEFgC8cgzgWOpmGE8XzESNRdBCzQ/pfgGlO50SKxtSwMXf/H4kxLa
         PpaoCOgljmH0T6cWna0a4KKDJm9pNW0Ges5MAZjBWnxfrvhTS5SG29taclPhXIsvrPbH
         aewwyupZ0UeppeY/9dbZDgdD2Gl8901gih5ffTBPpR+cULgzQw2JuuCDZi0E6+Dxs3Mb
         WmAA==
X-Gm-Message-State: AOAM531sYOYn8X9u0ywOswdmrbc6mbR9hM48uSv1rvitSuVWwQyb6VCU
        Jg7tpRQTxY6cj9nNnVIDnBuwdQHQF0IyHKEztV6aMg==
X-Google-Smtp-Source: ABdhPJzx77NzvV/SmsySRQaOio7nBF4qQqYJX1vVKRq5khbJvqP3qA6Ew1CDvacgKram6Rco1p9JJEXDtLy1oDeWlM0=
X-Received: by 2002:a17:906:d54d:b0:6e0:1f9b:5064 with SMTP id
 cr13-20020a170906d54d00b006e01f9b5064mr11937589ejc.59.1648021176257; Wed, 23
 Mar 2022 00:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220305074020.751309-1-davidgow@google.com>
In-Reply-To: <20220305074020.751309-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 03:39:24 -0400
Message-ID: <CAFd5g47kM_fd7AT2RRV88biXsLDpfrvKqKT2aaGNJGqdVwXGAw@mail.gmail.com>
Subject: Re: [PATCH] list: test: Test the hlist structure
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 5, 2022 at 2:40 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add KUnit tests to the hlist linked-list structure which is used by
> hashtables. This should give coverage of every function and macro in
> list.h, as well as (combined with the KUnit tests for the hash
> functions) get very close to having tests for the hashtable structure.
>
> The tests here mirror the existing list tests, and are found in a new
> suite titled 'hlist'.
>
> Signed-off-by: David Gow <davidgow@google.com>

I am not an expert on hlist, but these tests seem pretty straightforward to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
