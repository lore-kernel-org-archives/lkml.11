Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98CEC04A68
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 15:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiG2P12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiG2P1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:27:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A366B8C;
        Fri, 29 Jul 2022 08:27:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-119-232.nat.spd-mgts.ru [109.252.119.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F58B6601B77;
        Fri, 29 Jul 2022 16:27:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659108443;
        bh=FwcBwazYmQXJLuakqz5K3Zcb2Y9+PH3NRCkA7//8gAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iNiJcum2t1BmoV8iww9oWOQ7obyVOt4EGOK/UuDqCIJbvJ1B6V7WOPmP7Mg18WjlW
         7tCuPn99KKShl6ZhL4stRpZ0hemkYxqJu1f3QkbQ1FdLEOCq9VzOP9jxnYn877KScV
         UTa3Z9IxrFx6P2QLabj4JQGie+emlO+IG1qw1P8eYuHDt97rTM99wD0Cbr96GM+kDN
         jSo1riLMC7a/Lg+U7RSlStMKU3m2XV3Ltmmd3KIthmSfqf/Kqbu1gtdbR2gj1gXbCD
         p+RRD/NmBHzYzZHdEFgiUB1jMIrh5d9zWqwok7IOEhptVv3hC2Zc9jBU/LB+M86fTp
         cwvt90sFZdD4g==
Message-ID: <49fe9ecf-b1bd-a21b-8d8c-e4a33e3fa821@collabora.com>
Date:   Fri, 29 Jul 2022 18:27:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 09/15] drm/gem: Add LRU/shrinker helper
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
References: <20220726175043.1027731-1-robdclark@gmail.com>
 <20220726175043.1027731-10-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20220726175043.1027731-10-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/22 20:50, Rob Clark wrote:
> +/**
> + * drm_gem_lru_move_tail_locked - move the object to the tail of the LRU
> + *
> + * If the object is already in this LRU it will be moved to the
> + * tail.  Otherwise it will be removed from whichever other LRU
> + * it is in (if any) and moved into this LRU.
> + *
> + * Call with LRU lock held.
> + *
> + * @lru: The LRU to move the object into.
> + * @obj: The GEM object to move into this LRU
> + */
> +void
> +drm_gem_lru_move_tail_locked(struct drm_gem_lru *lru, struct drm_gem_object *obj)
> +{
> +	lockdep_assert_held_once(lru->lock);
> +
> +	if (obj->lru)
> +		lru_remove(obj);

The obj->lru also needs to be locked if lru != obj->lru, isn't it? And
then we should add lockdep_assert_held_once(obj->lru->lock).

-- 
Best regards,
Dmitry
