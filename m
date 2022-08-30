Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AEDECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 14:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiH3ORC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiH3ORA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:17:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337178673F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:16:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so1750502wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WZETe5RlyVKT0mHkiEDx5jjUAa3j1bwbGXJVlil3/kY=;
        b=J4qTyHLTavinZxE9B3kIh2MiXTWZ2/rNeGOPWnCnBVXCaHzzDowJfmfP/XJnAzlkBc
         cd+7GBsrBEnjn8+pl7XJFFl2T5YrVmAyWv9IFJ3Vnxagqrsa2dcyGFPKBlULmMiPNGt+
         B+J9PYz5d02QndfF3yM/Wj0iP5jdsUSLwF6DqcHJDURX7Y34P9cZ8zv7N+uu5HYZ6Rgx
         hAo1875ITavlgqKmRtAVRm9ARWDyBdrfl9S9I1Tfr7RYwkTZPwdrGan6+a5KQjyVbEH8
         MVHHu5XTgDnOO9r1yAc0B1QuZJqeVrjEct0u/q7VG5as5vVfDbPvcTkgmdbVxMB+6QqD
         7zFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WZETe5RlyVKT0mHkiEDx5jjUAa3j1bwbGXJVlil3/kY=;
        b=R/udEgCsuLZE0brBSBrAfEgddJynv6IJQdHiRSETMhfp0PaILaXeB08HwBhZ2G5kE0
         hmg4yy4BUFdldbG4npi0tT8yuMDcbQ81LHo3WM8yBfi2h6/G4IqH6JcIchq4jEl1Bt/E
         tUHCEiqK+WdBrlIz0OFEL9qwl5ykxVcwEnLy5r+OUgmK1L2EqI9Uoi23cERb8mOCptOb
         4fWXSz+y9NNd5v/MspQTUF7rycB980x4XtG4q1e42ZJBUNXGQGE4Otpi2Bvd8IkNmJx2
         4v9RLb9ZlCeNn8MvJTnujippxPMwKaK/NGDElvnQmac6usn/vngkyWgODESVlL2fb8dm
         LBIg==
X-Gm-Message-State: ACgBeo3IbOZp+2tS2jGKTrG8K3nf2eDI8g9NM9SUFZIf05DnVJ8+OnHw
        3pL9uJYr4qSKnHIhK1tE4b+0nYaA+z351pFhkQA=
X-Google-Smtp-Source: AA6agR4PoZk1zNtWhpMLc2uak0w5sDDnHx+9JpzXTawezmHRikzRlWPmyS5Vznj/c5ajdbA/IMGgyQLJy7dNMofdmps=
X-Received: by 2002:adf:a490:0:b0:225:2da4:10ff with SMTP id
 g16-20020adfa490000000b002252da410ffmr9255787wrb.1.1661869017665; Tue, 30 Aug
 2022 07:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802084146.3922640-1-vschneid@redhat.com> <20220802084146.3922640-2-vschneid@redhat.com>
In-Reply-To: <20220802084146.3922640-2-vschneid@redhat.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 30 Aug 2022 22:16:46 +0800
Message-ID: <CAJhGHyD050bnK4eP4sxgQKY22hzPM_cW74s20YC9dYJbXdprWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining
 tasks to wq_unbound_cpumask
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:42 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> When unbind_workers() reads wq_unbound_cpumask to set the affinity of
> freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
> sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.
>

Hello Valentin,

Updating wq_unbound_cpumask requires cpus_read_lock() and
unbind_workers() is in the CPU hotplug path and so it is sufficient to
access to wq_unbound_cpumask in unbind_workers().

The extra protection is only required when the logic is also moved to
destroy_worker().

Thanks
Lai
