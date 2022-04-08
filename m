Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 10:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiDHKDv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiDHKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:03:43 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8313F89
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:01:38 -0700 (PDT)
Date:   Fri, 08 Apr 2022 10:01:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649412095;
        bh=rusAaDnliVYRoqaWx3ZseyT0eG4DdEtRKyDQafUunhY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=tCALG0eT8UMW1BL26yI62yvZGYqUvlm4cJp6HVttJFU/Vw68LIV2BjpljM4Yk2N/m
         9UtMFeHqgbxq+W96l7dk+GGUmAYcK0bn3EcansddIBYaWYzPr+LLEEnrCaGDY+qy6w
         pHlaUS8CftUwPOTrMy7Thhm0tVPnPavcVt+CmrMIBIvuP3UVa9k3k3MmL1HiJUPo7B
         dOqYSAD8APV/Ov8RDlIWtgDmk/9hRVQZyxgzwK9I7mKsi+N5A3WOW42VePahZWg1+a
         6FVKiuDXihKa28jw/k3QxoLUiwRaQ/3KwPY0t4id0qJEudzImEtrFZ5lC1hfPeTFsj
         JOhcK2hBuHjGA==
To:     Grigory Vasilyev <h0tc0d3@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Evan Quan <evan.quan@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Sean Paul <seanpaul@chromium.org>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu: Fix NULL pointer dereference
Message-ID: <4o2YD5id7zhK5g__CUK3Yf-6Dj459XQ0qsydW6wKHdco3YYtl78BqGUfXvQ9UO0AZoAsMPfhFB0jw1BFldiFDcbZXmGgsobuAoTMWmoDqmE=@emersion.fr>
In-Reply-To: <20220408092803.3188-1-h0tc0d3@gmail.com>
References: <20220408092803.3188-1-h0tc0d3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is amdgpu_display_get_fb_info ever called with NULL tiling_flags/tmz_surfac=
e?
If not, there's no point in adding NULL checks.
