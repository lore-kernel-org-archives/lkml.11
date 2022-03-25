Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9554CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 05:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358348AbiCYFdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 01:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbiCYFdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:33:23 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D76CC559A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:31:50 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id p143so3691233vkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a4PJcCHTCEVvlLUaT7ewRFG6MEIBGGAe7l4+0cuCL8c=;
        b=Xyq3mxh6Z90G3mQQnZNXaK8uSMQPWtCUFTkTwA1uwqmYkE61BbQIeHCIFnFzEx0GjF
         aUTNepUavH5ZNujsKT+HCSBJNN5puLxJZyboPI+28H17Gdd3LLkUFMNYNU2C5trEkldu
         cWFpxr5xKmVtLfnc3XGH/C6MZaRAFJE5ev088LSrsipWKBO4v55RoWApMuAgpSiJBjoW
         c4N/qlp5lPk05SlPaQYYxKJPq4fnjwT3NEFr+fQfCmYVNxFAJg6ozHoXO4VecZf1/fo+
         xzekZjdP97Yzp77atXE00tvmBY5Zu+jh1xgA8GakopLlrt9V2hmEw3yyQGT6ogI/mjlO
         ff5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4PJcCHTCEVvlLUaT7ewRFG6MEIBGGAe7l4+0cuCL8c=;
        b=pGsD6qmLvehRms70BOfh+Hh6vhvsWo7ndaePRXIGI9rb7fbPGnShGo3hLImGSnGrG7
         RfwdD9BZ4CQY5X0a1wucKxLvPKiL6Q4Vmf4bymx5umVBesdHv08oAqyy1rAAY+Paaodo
         dxjhtR7X/1yKqJju/v2TpiOd/uYbK6P6diplEhty5JeExZnsBtcFC2PZ4WmNlH6dlisi
         Hfedc+oCBl75PC3CrZD80JSGOK2GqM6I3ORpcD+YkdOLw2c2RN3lZ4V0CqPQBJ4xCToP
         1vi4323q3ap5mo9xprXCWb/FxRkL7G4NjoUVquTpgBWjMSfSD/4F9q8RSF3cXrB7beSE
         bN0Q==
X-Gm-Message-State: AOAM533UHgrLmq/lJJ4gMBrCIz39vPf3+iKQPX+DRk+r8+sXBa7tW4Zb
        j4c2Y9px26gEbM2CLd7ZDUiAZRuKowGoJt6srNM/2A==
X-Google-Smtp-Source: ABdhPJxtlJzMmCJ9VzxrCpvTpgaUayzrIFCkLS7CFRYX0brqSKxaSXKNbbwD1/5PApfpO5azKscnC1Q88uYxBhya/eI=
X-Received: by 2002:a05:6122:551:b0:338:9106:479b with SMTP id
 y17-20020a056122055100b003389106479bmr4378393vko.22.1648186309258; Thu, 24
 Mar 2022 22:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com> <20220324145902.GG8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220324145902.GG8939@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 24 Mar 2022 22:31:38 -0700
Message-ID: <CABPqkBTVFNOW0Y-suYVRjf07aBC41gEw1m4Ym78sR39BRzLDcQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kim.phillips@amd.com,
        acme@redhat.com, jolsa@redhat.com, songliubraving@fb.com,
        rafael@kernel.org, ravi.bangoria@amd.com, Sandipan.Das@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 7:59 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 22, 2022 at 03:15:04PM -0700, Stephane Eranian wrote:
> > V7 makes the following changes:
> >    - rebased to 5.17-rc8
> >    - Restrict BRS to be used only with RETIRED_TAKEN_BRANCH event in order to
> >      avoid adding more skid to other events in case that are monitored
> >      concurrently
> >    - fixed bugs in the perf tool enhanced error handling for IBS and BRS
>
> But afaict you failed to pick up the build fixes I did in my tree :/ Let
> me try and be careful preserving those while munging this in.

Sorry. I missed that. I can resubmit if you prefer.
