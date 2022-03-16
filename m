Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7A8C43217
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 00:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352709AbiCPADp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 20:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbiCPADm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:03:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601615DA64
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:02:29 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qx21so848688ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 17:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZUG3daTjBSNeQ09LqP7cMF4OOdcfPX1L9Gvauwm3p4=;
        b=cNgJESNNXO6CVxh1c4d+IFacASUh8b8hgVKzMhf0/q+zag5BY3uZQIOsYYfoyq5v8o
         IhePtWh0pGptQ8qaIWEZ9Z/zv09alp3AXeFV1V4XZ2OoY8X6MAwlF5HKMjpar3uNPtFm
         ygSfHnZ8QD0cB6Yj7WRQ3IHzNH/l3OyZSY/3fCDCpwVIfWYy/6jA4VassSG4GsJUrTwo
         zXqIviTwFJiQf8MjjTwCtIREDtGBO5h4bt40DxwnQmmDI9mV99EdLYSG+eHM4Cv3gicF
         ZYzHFnrWPAIcDyFPZvWnIybAMgGlcum3r7hvW6j9MY0MFkON9H2SBXz5gtlzGLYN0KbE
         uGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZUG3daTjBSNeQ09LqP7cMF4OOdcfPX1L9Gvauwm3p4=;
        b=V5ey5GhMNQLEm27Ke6EwvDekhw0rRvkDOYxyXq3+1vetf8/rCrpIJxz4eIxGyfwmAl
         lifsC3UbEdbPcV91c7SHuwnnc8UBJpjvgr09bTDDQ9c6Ez3kBJckUKrTeZO76zQm8Epc
         JSBVX0Qe11bktsQfExQYxiNMCRFamTa+eegEOrtWOS+dh4gIO+cf1+BtsoNg6j7BiWIv
         n1Gu6jB0ywsvs8+BLpXswYrJrpYMdRhHVjxRVDAOJw4T0zMJd4uV3L4CYp8mvQpX7zpz
         peA2k00r64RLMHBOMXsMV+NjLAj8A1oNXVaHoX8y/aER/76sJBBsHVmX0cqEieeePZlS
         fD7w==
X-Gm-Message-State: AOAM531ib1n055M7yS1eOhXbTFN0WXp6u1WIodLfsvaL4GpsH6y8azxU
        qMqw++89yvwti7GPD5W1hzcQ9Y0P12+/gTY0eKZUmg==
X-Google-Smtp-Source: ABdhPJwOS0I4hArhmI83705iboyKEE6Janp7V5RBBNVLVBJ2XiVer4+vbsGzg4VWhvkr9vEvKQ8DOpavrHz0PqdnhEM=
X-Received: by 2002:a17:907:8692:b0:6da:866c:6355 with SMTP id
 qa18-20020a170907869200b006da866c6355mr25354574ejc.174.1647388947747; Tue, 15
 Mar 2022 17:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220315172221.9522-1-bgeffon@google.com> <YjDMo35Q/cvPLkxu@casper.infradead.org>
 <CADyq12yK+qODV2ut1acjwkyXKDbh_YS3MHpRoJaq_g9G1HAyEw@mail.gmail.com> <YjDQj9dr34Jpw3cU@casper.infradead.org>
In-Reply-To: <YjDQj9dr34Jpw3cU@casper.infradead.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Tue, 15 Mar 2022 20:01:51 -0400
Message-ID: <CADyq12y32GFr9FmJ2-u1rarozb_JegJPeQB8L9q1E3LZJ20zbQ@mail.gmail.com>
Subject: Re: [PATCH] zram: Add a huge_idle writeback mode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 1:44 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Mar 15, 2022 at 01:34:21PM -0400, Brian Geffon wrote:
> > On Tue, Mar 15, 2022 at 1:28 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Mar 15, 2022 at 10:22:21AM -0700, Brian Geffon wrote:
> > > > Today it's only possible to write back as a page, idle, or huge.
> > > > A user might want to writeback pages which are huge and idle first
> > > > as these idle pages do not require decompression and make a good
> > > > first pass for writeback.
> > >
> > > We're moving towards having many different sizes of page in play,
> > > not just PMD and PTE sizes.  Is this patch actually a good idea in
> > > a case where we have, eg, a 32kB anonymous page on a system with 4kB
> > > pages?  How should zram handle this case?  What's our cut-off for
> > > declaring a page to be "huge"?
> > >
> >
> > Huge isn't a great term IMO, but it is what it is. ZRAM_HUGE is used
> > to identify pages which are incompressible. Since zram is a block
> > device which presents PAGE_SIZED blocks, do these new changes which
> > involve many different page sizes matter as that seems orthogonal to
> > the block subsystem. Correct me if I'm misunderstanding.
>
> Oh, so ZRAM's concept of huge is not the same as the "huge" in
> "hugetlbfs" or "THP"?  That's not at all confusing ...

I do not disagree, but there isn't much that can be done about it at
this point given the sysfs file takes an argument called "huge"
