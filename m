Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEFC35276
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 22:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382182AbiDDWNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387287AbiDDVnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:43:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAAA2A2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GnqPArbOXdhcZS+LJY2EmWrv3832lf7vaIWabZ2xbUE=; b=EiRMFCvQqDGwaQ9rJ48BY3EN28
        WMsLcZiApzlIMRBLCcGMIYSfsppstCmPxaIHNBz5HXAgiuLqUGMnAeMSbyrA0XdKlYCCcYAOzSLZk
        NuNmpErUlcuvbJ/VzFrGhC0LLkyPLBC8V/5eRz2tbzp4e1FlQBxxHgqrUfdusq0FT5wL4MxJkybXO
        S74AEOpg2/q8oiP1TZ61CsK3r6UOWHUB8+d4PCn9cMCLK4wqEbPlqcdJqcLTJkifCSNq/qRB7oTA7
        ay2294GqAMXHHCtrfF00iKPr3qHgg2Dxdz9dAjHDctlQ+Hyr48iKVhEtR8CwD5JJLoy3tEs+7nSg9
        iJ3O6t1g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbUMm-0064FZ-TG; Mon, 04 Apr 2022 21:36:05 +0000
Message-ID: <b20bbd22-895c-9e74-e579-d2f3561a2fe1@infradead.org>
Date:   Mon, 4 Apr 2022 14:35:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Content-Language: en-US
To:     Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
References: <20220403232902.1753-1-rdunlap@infradead.org>
 <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 4/4/22 09:04, Simon Ser wrote:
> Both doc patches pushed, thanks. I had to manually edit them because they
> wouldn't apply cleanly. Next time, please use git-send-email (see
> https://git-send-email.io/ for setup instructions).

That's odd. I did use 'git send-email' and I don't usually have any
problems (AFAIK). I'll check those setup instructions.

thanks.
-- 
~Randy
