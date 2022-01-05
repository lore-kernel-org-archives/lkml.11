Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B041C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jan 2022 23:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiAEX6E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:58:04 -0500
Received: from mail-4018.proton.ch ([185.70.40.18]:11807 "EHLO
        mail-4018.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbiAEX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:57:50 -0500
Date:   Wed, 05 Jan 2022 23:57:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1641427067;
        bh=20o01XlA0KPZSVp+vlUsACYY1X55JbN6UgC7f+UelqM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=KU7HMLxThumPxf7UkHKfua0m3uvjETarY89Q6xNfLsKAupnOUDSGwLh4gFmmjIooM
         PwI6oSoozg8F0sxWHrQbwxLILF6a3gxDkVY5PKJNCv9StTxCxaGLHPVDF/pAqPWuk6
         XJlpuNFfEWZRBr0waV3YyrIUN37BIX7WUVO4cQQU5smtfteLpKX0rkpNCADCWpwX6W
         Y2K6n2MuJRDtnUVWxpoMrVqzp2WaNHMpb7JsacVeM2tMFuqJkcxGIAboKpTyef6XW6
         aw3JYeTsq5ixP+ApGdEAng42e1/xrPs/MiL/DrHZD/I3ebikszo+4uLqm6dZvZLz+6
         y63PAAChf+wvA==
To:     Tomohito Esaki <etom@igel.co.jp>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC PATCH 0/3] Add support modifiers for drivers whose planes only support linear layout
Message-ID: <OCRYf0WjHfvIDxKeXD9eR8KiweNqCTcuy5QUapIIYgtas4x2m_nNc6mDZGnhO-y1H_yYh0O8qzzgAWdExGyK-FjUExqXY1CDlCtSDevNmWg=@emersion.fr>
In-Reply-To: <20211222052727.19725-1-etom@igel.co.jp>
References: <20211222052727.19725-1-etom@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for working on this! I've pushed a patch [1] to drm-misc-next which
touches the same function, can you rebase your patches on top of it?

[1]: https://patchwork.freedesktop.org/patch/467940/?series=3D98255&rev=3D3
