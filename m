Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6655C35273
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579060AbiDEXZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 19:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573656AbiDETfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:35:06 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3171245BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:33:06 -0700 (PDT)
Date:   Tue, 05 Apr 2022 19:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649187184;
        bh=rizVX8SaxkopwG+PgRvZo+RGKMBEJnMwXHtVKUz8fmo=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=wmTleW8zMQpVAVbXE3xUka7RwlsA2DK0Pab6drVgGGVbpHvLfSEvG1ruDB+ninz60
         MwmwlqMTwKrZlJuU1rJFSJv9ojTprWUmeRJ1Ukh7roYxn6CR5riVoqGj76tApG4y1U
         IEaYk6QJFNCtlO4SeoNBA2H+HSibOEyd62Ur/C5VEI94bLsGeYhYHkXwRdia/1/jkg
         Wbm5Ns3QcOgKwMdn5HoPlqtA0te0CEnmUk7dqa1W6IjhFuFr8nqbzgnD0z9lnY7U8q
         VTHNe3cyczDk3H8KFVaCZngeq+bnRvCk1tkeIlZcjjoNZwVnwMuk7oMbTQhtwtt6KV
         PrHwo1QiFHsYw==
To:     Melissa Wen <mwen@igalia.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Agustin Gutierrez <agustin.gutierrez@amd.com>,
        Zhan Liu <Zhan.Liu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        markyacoub@google.com, sunpeng.li@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2] drm/amd/display: don't ignore alpha property on pre-multiplied mode
Message-ID: <oPxlwpfhK4TKsOfqVS-hfX4WN9CvusPH8C6rRq_NKYMh_YocjF9eBY13cALFQiqfCH_OgjIcXFkrjPU_bndAItgl31kjkkjmZlIN5vy7lxU=@emersion.fr>
In-Reply-To: <20220329201835.2393141-1-mwen@igalia.com>
References: <20220329201835.2393141-1-mwen@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested this patch and it fixes my bug [1]. Thanks!

Tested-by: Simon Ser <contact@emersion.fr>

[1]: https://gitlab.freedesktop.org/drm/amd/-/issues/1734
