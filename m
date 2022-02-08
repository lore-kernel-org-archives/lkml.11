Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924FBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 15:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379432AbiBHPEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379219AbiBHPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:04:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6BDC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:04:39 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k1so14754402wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QucZOh+L0x1kuUchXX+XOyw1VcfuGS6zeDhpxjRwhpY=;
        b=PkMkAHn32wn1oj3AjB6hNFd8JXghauWpEpUhkWEB1TdQMlLEZzITPQhav9n/jIiC1o
         RBQocoml5MwGgOej4MjSzRTyrkzZZW9RVklnf8oxfFu3kAX1TyL2IHWLRIBnmgBS8xmu
         PeMQq7QcNxlT8VGrBn82k6iXrbpcrYDDU8stssQuCCffOEqfmcHei1gHBmoBWvZ7Wp4P
         8L/cnJS/GksURJ3mcjA9prf+QdEfh7WtZDD8BbaUNVc4fWp/xi+6SeDsar6t4x2dfYwO
         9UJGoDUn8LuiwBj0qQ3aa6YRzFqwsKuDFnzrGJRdSVCHpbS1j1oUiykZ4DK86Flv97WU
         Ei5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QucZOh+L0x1kuUchXX+XOyw1VcfuGS6zeDhpxjRwhpY=;
        b=oRfmLDRhDaV2GhShesTZWXZy8td4iJc+XNtN7SDnTMHP3OLOec1dkifP9b2+9uUsIg
         jyl3mfRzTpp6Ltb56wniDlip86CPbqG6dlhaShfLeiIscr064at9DuNRJlR8K18QegCQ
         rq5o7P/8HAvS+Hh49HBpRAJpVE7yTroK3dT69yVSgBBkHIG47nHGgptDqUHsbY6F3k3E
         RKZqYGXQg/VgrUrBdqR2MwK9/3o5nGc0BocNSx0Fa86Ip4550H6rRupM0A8bNheXTryI
         XPsYLott7bhm8efJ0FeDK2RQ5yYSLzlIi5JgcN38NmQF4f6yyHcObs4UpjE4CloL5Xuj
         /vMA==
X-Gm-Message-State: AOAM533qoWhPtCVGfz9w/LgROq3L7e8ZhO176WZJmjAcR3HpIdOb5pmj
        WcTTo51uBvLWE/tHcH2oF1kQ8II/yN1pf8YNWgdq/q/qurQr6w==
X-Google-Smtp-Source: ABdhPJwVhk+3SRtHLUVcgo7zQF+9ELDXxEw6Bomr25Q3I4fffDfwTfnqbDNaX0bakz7CzNz+/fFYgaZFk3D4cOSd69M=
X-Received: by 2002:a5d:5848:: with SMTP id i8mr3861203wrf.342.1644332678074;
 Tue, 08 Feb 2022 07:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20220207043640.2829295-1-juew@google.com> <YgFqiJOU5tZsHbY6@zn.tnic>
 <YgFyBRIOIquMI2ng@agluck-desk2.amr.corp.intel.com> <YgGAv/aCVG+RDADI@zn.tnic>
 <be53997f26704089b941d33d9bf47bc6@intel.com> <YgGNDenGMCE5ixXw@zn.tnic> <5293d81863b54d6ab0835012201d44da@intel.com>
In-Reply-To: <5293d81863b54d6ab0835012201d44da@intel.com>
From:   Jue Wang <juew@google.com>
Date:   Tue, 8 Feb 2022 07:04:26 -0800
Message-ID: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
Subject: Re: [RFC] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, Tony and Borislav.

I will send out an updated patch.

Thanks,
-Jue

On Mon, Feb 7, 2022 at 1:51 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> >> The erratum has made its way through to the public specification
> >> update yet :-(
> >
> > You mean "has not"?
>
> Curse my pathetic typing skills ... "has NOT made its way" is where we are today.
> I don't know when that status will change.
>
> > In any case, I guess you could say something like:
> >
> >       pr_err_once("Erratum #XXX detected, disabling fast string copy instructions.\n");
> >
> > or so and people can search with the erratum number later where the doc
> > will explain it in more detail.
>
> When the errata (plural, there are separate lists for SKX and CLX) go public
> we could update this message with the names.
We've found this message in combination with logging about the
faulting process info
in do_machine_check helpful when analyzing the originating context of the MCEs.
>
> -Tony
