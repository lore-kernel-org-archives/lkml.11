Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A2C00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiHAPqo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiHAPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:46:41 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158282E6A4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:46:41 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-10ec41637b3so5959946fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=FKWfV0YKdSbGcGL8JfBr05jog3rOXyTHkyO18qbmTgI=;
        b=d80b217wQpzIfjlSI8irMsaCmjnFVjXFrweqO9678Db2IH66hhASVQkm33Ehcb/Pig
         L+ANg683Xv3QIy5OdIM2judb/VY/XgufoJIkWQ9eNOSdRVmuE6vnmbQrpgwpV4ERQWKE
         nTMZvYP7AcYaihgq+da6CMskk81FpE7E5M93A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FKWfV0YKdSbGcGL8JfBr05jog3rOXyTHkyO18qbmTgI=;
        b=M1n3LRq5wFNG/LPpeohhtwgMI7v0mp4IK2H0jnPZGR1LKaPYH6msUcKFoMP5yRU8S8
         pbTC0HUPCAUy4ezqQyYML7UWIFzLLl8Rl76gc5Mt0XV7xrjkih9Aa+qN5+9AjM2aXU/w
         K/tXX9JvwSMw7roETNR5n2yNADo0gVOA27GrQRD0b5V+XLcu86RFgjbz4BriLyCzTOZy
         L7nYrpo18KFDFSe/siWJlc+8pbvSIJW/YnxdKH8rtWTkhruzpDbsxCtjRsnIaKPodvL7
         LSytR4w/WA4CXhbvnkKBJ/uLkwC8Iz/E6+CQc4acvSn4/rPOsbssXzEJ58NMLc8IBNMg
         k6Hg==
X-Gm-Message-State: AJIora9kvl8yFt9ndseMi2z4T9gGHzqSKOB3Qw1aZga5LOCkbOWNLsC/
        aTcGmXq3TJccww38/33BDSkEXiNgn3kl8lAhdQg=
X-Google-Smtp-Source: AGRyM1tLnZGetW1mCMPAMzU+kKzzUJ2QjN9DVsQsh/yqxgvuxubKlQ7DRyF8Uu1Y3QaH2N6d9UZKpw==
X-Received: by 2002:a05:6870:a198:b0:e2:6f65:b91f with SMTP id a24-20020a056870a19800b000e26f65b91fmr8108844oaf.192.1659368800203;
        Mon, 01 Aug 2022 08:46:40 -0700 (PDT)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com. [209.85.160.49])
        by smtp.gmail.com with ESMTPSA id a17-20020a9d6e91000000b0061c7adb4006sm2850625otr.13.2022.08.01.08.46.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 08:46:39 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-10ea30a098bso9251892fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:46:39 -0700 (PDT)
X-Received: by 2002:a05:6870:65a7:b0:10e:d8ab:dd79 with SMTP id
 fp39-20020a05687065a700b0010ed8abdd79mr2693975oab.53.1659368799695; Mon, 01
 Aug 2022 08:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220801144329.GA10643@redhat.com>
In-Reply-To: <20220801144329.GA10643@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 08:46:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCi2LLzSJg_7nRs+nQbVgT8HwEKzjMae_4geVCA+1SNg@mail.gmail.com>
Message-ID: <CAHk-=wgCi2LLzSJg_7nRs+nQbVgT8HwEKzjMae_4geVCA+1SNg@mail.gmail.com>
Subject: Re: [GIT PULL] dlm updates for 6.0
To:     David Teigland <teigland@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 7:43 AM David Teigland <teigland@redhat.com> wrote:
>
> (You can ignore the premature 5.20 pull request from some weeks ago.)

Gaah. That was the first thing I pulled this morning because it was
the earliest.

And apparently you've rebased, so I can't even just pull on top.

Gaah. Now I'll have to go back and re-do everything I've done this morning.

PLEASE don't do things like this to me. If you know you are going to
re-do a pull request, let me know early, so that I don't pull the old
one.

                  Linus
