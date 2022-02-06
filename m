Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B66C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Feb 2022 19:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbiBFTk7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Feb 2022 14:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBFTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 14:40:56 -0500
Received: from ixit.cz (ip-94-112-206-30.net.upcbroadband.cz [94.112.206.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A894C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:40:54 -0800 (PST)
Received: from [10.0.0.111] (_gateway [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2DA9A20056;
        Sun,  6 Feb 2022 20:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1644176453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GszLNhMexLpLLdemM84LTJhxhkHraxd8L6Hl1gvyo7k=;
        b=W8l16qF2FXpoSLj8nP+5jXthayGpPU4iuSNBhwCiDHSMvlzNUqvdrdwl00mzY9Re2QYC15
        5HvtPQ+bbo5MkvAlVZLQOOK4dVUkPpup9+73rDeb6gtuZSy1AISm/k9M+69BoFiE1NYbNU
        8cmHzahnRWjvujlkCMufvh/rruC+Q9s=
Date:   Sun, 06 Feb 2022 20:40:47 +0100
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] drm/panel: JDI LT070ME05000 remove useless warning
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, ~okias/devicetree@lists.sr.ht,
        linux-kernel@vger.kernel.org
Message-Id: <ZNEW6R.0SLJU7L5A6PW2@ixit.cz>
In-Reply-To: <YgAg+lklFqPhVgS8@ravnborg.org>
References: <20220206190702.450643-1-david@ixit.cz>
        <YgAg+lklFqPhVgS8@ravnborg.org>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6 2022 at 20:26:50 +0100, Sam Ravnborg <sam@ravnborg.org> 
wrote:
> dev_err_probe

Amazing, thanks I'll send fix right away.
Davi


