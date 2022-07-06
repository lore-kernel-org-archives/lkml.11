Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DD8C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 18:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiGFS7F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiGFS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:59:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D81EAD7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:59:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r18so20404733edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJBGd4YWiUvcMgoxfpT1QB+xxsar8YQaWyM+sKP7ZWQ=;
        b=Ha03cEmXtorTod0JjdWM7qlCulK5jqVzsbXnMzrHqrcKjlt9Ma3N59CDMyu1eMZrsG
         UgLyAUK58xH+I6ypU5n9XI0hQviOL6iPVIN3YpyXU1UrGg6v6XT8KknMx2ICrABkWJi0
         LpxFEYgv38vGoni7rA+EjR+FBusEIlvlvEQBwS6PP7QqUdl1jUM7wPDKILu/1/yVkVi/
         0HYjOPejeE0+qkRMvNpfHtAl5+BSiyc/GgJs3HUdFKd2kfLBFxnBqh1le5hpMsVbrOYH
         nV6uMh1u7zL6037NxeP4JDqRDuk2cGg9L5kgs8SY6bsuFg6v2HykiLbnTeP3UGIbizt3
         EZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJBGd4YWiUvcMgoxfpT1QB+xxsar8YQaWyM+sKP7ZWQ=;
        b=gMbm6H88PGgXUhZCWvZzu87SMoeJdNu69Okw+uXnTyTld0YzAdipuNLmlmbvS54V62
         ffobedyzNS1sSKKDoctlO8rKDToN2VwTJtzgy6dMpGhZ5FA7ZZTs7mrfFReScJEyxudg
         AEp7WY1LZz6tSrJqmhMqI0zcM8DPT02rebojUWOgzBEYJeHhhAJgv0BM55A8GMCOBomQ
         wGSZQxRU/A2X91arqvZp9zSNU7ax2DdxffQCy8GFtjcup2lyzkgr0zE1gnd2j4ytx8rv
         OG050cUOHlqkWrDASzPgcp8/Bu0Q96Gc8FAbEiXl9FV2GD4Jyh0Z8Q2pXjVWwDqh/0FC
         E3tg==
X-Gm-Message-State: AJIora8OpjiObmCdYv39/+9FsmgS9ZGi4XVKrt1W/TrHzILfMyq/RFuq
        piMLshZUeFGnFFwG559wrO4XWQ8nt+IUnv7MO51lSA==
X-Google-Smtp-Source: AGRyM1vTicJO+szVHVNfKuAfRJ0zZgZaaiG7xOw2TtlxNbtKOPv5thsTbIRTuGpZMrgB8p9agM1Z4R7ryZ8gR+RtOrQ=
X-Received: by 2002:a05:6402:43c4:b0:43a:6309:6c9b with SMTP id
 p4-20020a05640243c400b0043a63096c9bmr22459868edc.91.1657133941113; Wed, 06
 Jul 2022 11:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:58:50 -0400
Message-ID: <CAFd5g45ByGFAmoOAy=BBBXouk_h0hT13ZLHTzY_hv30B8KfL9Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] kunit: tool: drop unused load_config argument
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> It's always set to true except in one test case.
> And in that test case it can safely be set to true anyways.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
