Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F1C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 May 2022 02:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445386AbiEGC4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiEGC43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:56:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8F84C437
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:52:44 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v59so15820573ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+aARka73pRNnVNet6HMvyJ5k9mv+3Ksu4uD0/m64JI=;
        b=ObPyXsqhZxsJyWR/3aHiwynl3EvkJvHyGBerKuqh54qM4RAN0XJpUjDRfp+VfCENEs
         fe5bYRiZ8LqlN1lOHPk1AFtFddf6qnGgyGuDstUnXEx7RhiTiYM8V8pjlrZLLx7l3mUG
         dmkyQp7PYaheos4zcn8lnjOYWAVuaTc8gIyTXx2Fd32A2wk3jSgAlX0Cn2oYCzmNzprW
         wchksqmsvI9ODk4suohMe+lg8g/1BYUhzCJhZI5cLZaXmWApXiHA1EPLJn7bX8jsFDHy
         PHfv4SY9YW8OHVxsp5aHQsN+U57g9Mp7+g0dBOPjq60n/b3t7lFJ/RP613kGniRE1L/d
         Z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+aARka73pRNnVNet6HMvyJ5k9mv+3Ksu4uD0/m64JI=;
        b=LJrQuy/wXhDmmWIqd2xL4QOnPBKHhVu8HCxdUMoMZ2okSlIVEcWvvdONGUI7xwMiBE
         MuFNAt5RDR1c6SwCRKzoagyWBpNsAmIKnSfe3dvxwvGxaHOLjSJFgaPjYnQHBW+/kFLW
         LJCRuPmvoBcXQ7SdlTO+m4jD7enWzKm7qGdVxXcuA9myNSW9pyYrz0Qrij6ev5Z9UPne
         3rj6z0rsmb2NzlZd7qnvrqZbkyULlO2IJixq90oPclJSVL0+fLKsvS0NvR/6AHgu1csb
         l2dFusiKzsXwle85MteT2apkTxzVOOUMpKOcPwMKf628+Ol/yMatxgKuJ7tzyWXbFhhl
         QDDA==
X-Gm-Message-State: AOAM530QsYFrxO55KnT49A8CGLTtq2lPp1xz6nk55o7xaOOCGuDOvDo2
        /aKeyRlQsdgpRZWbbwjZXxkNaKqkmsFq/AVr8kQ=
X-Google-Smtp-Source: ABdhPJw2INUOB6juaUMKyWUPyj9rL+kosM0PPkRV6xLOPcJXqH2dMkRr1kR+wpaObnfU1Z1F3QhlSZ233MaJVhTZBPY=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr5083905ybg.352.1651891963895; Fri, 06
 May 2022 19:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220506121431.563656641@infradead.org> <20220506121631.365070674@infradead.org>
In-Reply-To: <20220506121631.365070674@infradead.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sat, 7 May 2022 10:52:32 +0800
Message-ID: <CAJhGHyBkpwn1=wVTeMCpQmiq_=n3HzsEzHiipkK8GmJfkYJJaQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] x86/entry: Remove skip_r11rcx
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 8:20 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Yes, r11 and rcx have been restored previously, but since we're
> popping them anyway (into rsi) might as well pop them into their own
> regs -- setting them to the value they already are.
>
> Less magical code.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>


Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
