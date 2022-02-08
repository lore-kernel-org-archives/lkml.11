Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDC4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344162AbiBHBtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbiBHBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:31:39 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1023C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:31:38 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id bt13so21440160ybb.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 17:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCJweZfHtprqNwQuPKuSEa8equXJDKCDWHoJe/Xk+94=;
        b=fmLm2+b0Vi8fyFlno+sBzlvxdiOinqMMSjhhIC3lIyAfleRXnfHq74bS8lB/mSNU8r
         6jXDw5garFcyc7Ibtr6uEe4zrLDIHhuXcAVhvSYY8XJk0M9XM2O4lmcd1N9IThzroYpZ
         GucSNu7NmuuXNL0Ogw6Vd9IvU1Z5hyTPnJEJgWN+khl8OBW3dRCn4iHISMga3oykiq7U
         /odbVMN5shA5S6T1+BhLTqlF1xEgfnx7Wvx7GmHCeL4ye0G2pCRNhk1L4EJTbXHbPAWc
         Dgyv9VK9aMkYe5wpKd+SpryQ89VHUSyQubkEYPIopT0zcrKn5+/SeOfDcTM6mu4ZSSTC
         OYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCJweZfHtprqNwQuPKuSEa8equXJDKCDWHoJe/Xk+94=;
        b=I4zz8TlrSqc6ra+R3UScHJ/bpOqh3Jq7xYMNXHNnkexIZZ/e25rdqx4zmvYeTsVKx4
         MmXjN63psC6ufX7l1x4Vq0dW0+hewm0E9oW46EjLVye5zP1xBSvJXYfaN/u5m4fVvluI
         m0pemRGcOaU7cn2Pi+gGNtrLt3RDjV5Rsjz31/5koDMVU7T/bJGiQoIjr2QTSNpLJLZc
         WTx1iOpUiVO3Byiieul6hD8UBeQRdShhU+lRrPlSKJOMp4NKAzSrqCfG25XRBOSnPLwf
         KCUzHj6FFgsorxKrdA2kq9y8UjokUtuirwQCVBnHEKkCjOsiglg62A5y7/izVE/nyOaq
         Isiw==
X-Gm-Message-State: AOAM530p6rjknNM9gOIeGgTyxnS/xx/mPpn+VUbWYJJTn8KG+KbMAukd
        DYGRzv5ooHZE1X0jFcWXA649F/kHwW3pcvnp+ceasQ==
X-Google-Smtp-Source: ABdhPJx2mKqMDRjehybx6rXQuL9bFCnGNeOOYN9Q7Az3jEMiEEcSFx0PdKX3wUIXfBWRwy8D1KGwzva4m8d0S9EV95E=
X-Received: by 2002:a25:7a47:: with SMTP id v68mr2663451ybc.488.1644283897723;
 Mon, 07 Feb 2022 17:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20220128131006.67712-1-michel@lespinasse.org> <20220128131006.67712-23-michel@lespinasse.org>
 <20220129121319.3593-1-hdanton@sina.com> <CAJuCfpHBfSQBuz8=LHYhX-aOgZ1ng6nNfpv_jeBLz+KVr1OU5w@mail.gmail.com>
 <20220201020958.3720-1-hdanton@sina.com> <CAJuCfpG95cA68Y047MKsXYjvGMENXsjSzHkhYktagcT=fjagWw@mail.gmail.com>
 <20220208002059.2670-1-hdanton@sina.com>
In-Reply-To: <20220208002059.2670-1-hdanton@sina.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Feb 2022 17:31:26 -0800
Message-ID: <CAJuCfpEEWFYJehwRhmMAEBx8+gf6TsV=kxuSGDVXaPwhNLt1JQ@mail.gmail.com>
Subject: Re: [PATCH v2 22/35] percpu-rwsem: enable percpu_sem destruction in
 atomic context
To:     Hillf Danton <hdanton@sina.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 4:21 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 7 Feb 2022 11:31:38 -0800 Suren Baghdasaryan wrote:
> >
> > Sorry for the delay. Are you concerned about the use of spin_lock()
> > inside percpu_rwsem_async_destroy() which would become a sleeping lock
> > in case of PREEMPT_RT? If so, we can use raw_spin_lock() when locking
> > destroy_list_lock. Please confirm. Thanks!
>
> Yes please replace spin lock with the raw version which can fit in
> more scenarios.

Thanks for confirmation! I'll rework my patch and will send it to
Michel to include in the next version of his patchset.

>
> Hillf
>
