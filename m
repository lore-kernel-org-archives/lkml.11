Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D550C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 15:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiGVPHB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGVPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:06:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D836184EE1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:06:58 -0700 (PDT)
Received: from [192.168.178.53] (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 51B6F6601ACC;
        Fri, 22 Jul 2022 16:06:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658502417;
        bh=talAFwKKsaOv9iY2eGoXpz6PwEbul7ITq/1xEmofP3I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Sea40vgUTv/2odG8rMIWpOXdJwGZxjpHbdjjPbIlHeG4/UuNgRz0wAQmeQmtzc8g0
         0SdX1O0A9MMzT7I8lvDwt1ZnVp5mMwaZKxGOHZKP7csI5d2BiNHfEszXz+GXwWhR42
         tCxoG7NgynEIUIVto0T04imAzh8g1aq7o/xUUhq+SDjRiSQP9aWSxYNsaE1524zfyg
         vtEiwFj8kKBiVIMavZ0MDU14sIIfilNR8v25pKo6YLTNVwxQCD+s8Vw8Ir1iVvLcOK
         uEc8QMgXst2mWYKrK4Wg1fFt7YiIQnuRHyaDM3u8xle+rGs5Q6S+n+MJkQuAXSVvn6
         /jaJUQDrYz93Q==
Message-ID: <1b35338a-e189-2134-5c87-e2f2edc54cee@collabora.com>
Date:   Fri, 22 Jul 2022 16:06:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/i915: stop using swiotlb
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220722145920.1513509-1-bob.beckett@collabora.com>
 <20220722150358.GA7152@lst.de>
From:   Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <20220722150358.GA7152@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/07/2022 16:03, Christoph Hellwig wrote:
>> +	return max_t(size_t, UINT_MAX, dma_max_mapping_size(dev));
> 
> Shouldn't this be a min?

eugh! yes. Stand by for v3
