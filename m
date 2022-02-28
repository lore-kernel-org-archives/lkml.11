Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18504C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 22:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiB1Wrh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 17:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiB1Wrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:47:35 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B281405E7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:46:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id h17so6387507plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LglAJFBfW0192A+zdtC6aPQEwQomXk3iQX8CrMvwboE=;
        b=Q1mmID59L3r+ZQjhjmMSnqIrxTddfLL+dg5Yncv+WGGQrW3mSeBNuaKUkiOgbD16ON
         Y0LTiD+wKPqFjsANDBpDGbLewVglEMBb+vPQ7iNIWROAxQKLDwNXCF+WYl02BWzhGLrM
         RHRxrBI1VRXCO9gQotZhnjXQoYxNZA/2S1cnEpTKfFZzBzDcEjjcpQ4O2PnBazcDncIs
         +nVGzkVgPfD0o3Bbl0Qfx8P6RFMUgV/vo7Bq5I8obRVLwbq2yKktjX+2sOG0qerdAjJ8
         I9L84JOIAHkzoTTOeBLgd7XNiy6mErmdRwXno8BokmhWTsT2XfcKd6xPZPwgfGwfXHJW
         UKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LglAJFBfW0192A+zdtC6aPQEwQomXk3iQX8CrMvwboE=;
        b=es7uVU9Zp/+WkWFGajeaYpMFYsTgP8iiO5HBtE7kYx9WMCz59bFHLtiwqQe62vvIvx
         L4nn5oWmMx4qVIbEKMOnDB/v83iKjzWUBdE2M0/4TzLm1NlQVzEVzlLGFlfbfuf0b8/3
         krUnfKyYA7aS9ccLKvmOBraw0YdzFX32htxPzc5AHakMQP8u7scajE/fOzzu8SBTO2Ob
         letHaoRb3hGN2snU9zprAZ+/Q4DtjCzRQNvmwxYzDQS3zkNWgYjJZncl3bBH+1L1MCN9
         G5avsXGKScMkbP+mRvE3T6J0URDf/Wk+nVJCMOKG/yR73yCoJR5tRG2yCNI/tVwGiki4
         zvlA==
X-Gm-Message-State: AOAM533PAyijFcJx8SF3RUBJBb4qKv1H6/RqhGK+p7mAmd8cMszByb8t
        PTq5FgGUzsev4LFMlVY8cAEQRo2cDrdpl1dhfXInew==
X-Google-Smtp-Source: ABdhPJzsghlkq6BU0I6LPAO56Tv+4suMMu6V1k1d4Uy6Z43D+GNTocRNhUW9x/uRixnOWsMjqGp30B9Php1ZVuXO+Kg=
X-Received: by 2002:a17:90a:db15:b0:1bd:71f:8123 with SMTP id
 g21-20020a17090adb1500b001bd071f8123mr15955979pjv.126.1646088415342; Mon, 28
 Feb 2022 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20220226002412.113819-1-shakeelb@google.com> <20220225165842.561d3a475310aeab86a2d653@linux-foundation.org>
 <CALvZod7SA17vounKnq1KX23172rztNN_Oo0K1XaeEuS4JVEhMw@mail.gmail.com> <20220228184653.GA1812@blackbody.suse.cz>
In-Reply-To: <20220228184653.GA1812@blackbody.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 28 Feb 2022 14:46:44 -0800
Message-ID: <CALvZod61XyMJzrvU0Wvp8iWV878rZQYsa407RhoZYeiJV5j5SQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: async flush memcg stats from perf sensitive codepaths
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:46 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> On Fri, Feb 25, 2022 at 05:42:57PM -0800, Shakeel Butt <shakeelb@google.c=
om> wrote:
> > Yes, the right fix would be to optimize the flushing code (but that
> > would require more work/time). However I still think letting
> > performance critical code paths to skip the sync flush would be good
> > in general. So, if the current patch is not to your liking we can
> > remove mem_cgroup_flush_stats() from workingset_refault().
>
> What about flushing just the subtree of the memcg where the refault
> happens?
> It doesn't reduce the overall work and there's still full-tree
> cgroup_rstat_lock but it should make the chunks of work smaller
> durations more regular.
>

We can try that and I will send a patch to Ivan and Daniel to try on
their workload to see the real impact of targeted memcg flushing.
However I am not very optimistic about it.
