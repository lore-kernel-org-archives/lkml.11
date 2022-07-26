Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50FCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiGZHsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbiGZHsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:48:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428AE27FC5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:48:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z22so16735399edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FH/29theWqCi+bWe4cZkC9kVr9XrvsNj1wv53N0Mxyo=;
        b=yyUauTSIja1NS2kRSo57hxSmByY69K71T1R02GJNP+Bz+KRkj62kj/6I4QYkyuPnH3
         19aLTtpfVlfw8hNqrFIeHWqKF+mhZnCMyJepWZVhaIkhI575pijXqqm1wOg2+sJapndR
         xa6WKQe7GJ3woUuVnjrDJ+TyrFZkxWAQjfkmrIpNRqc3uvi2OGGMhByUW9dsXTHKeMes
         YpNPNP0XI7SExk9eqs02E2eTIb8yoKSN/RSOIcLaLmlQk3wiQF10yPbXW/x7uqstLbxt
         AN+h0RtlCnFWRnn2RSSA9NBwhBiHu8h8xVWct83S8KQH54VKwIKHUt+I/XEpxGTq7k7+
         ITDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH/29theWqCi+bWe4cZkC9kVr9XrvsNj1wv53N0Mxyo=;
        b=d29HLGZKmM+i7NQ8u/U/UGrcpAsd+ZQn/4HZeJ+eqdNy2ej2pqnEcx9gvkOPptylGz
         0G/yBDn5yi0ED0hxy7U2SjH+YqyKhgIAFzU9yCnqgDNbXzGIfKl93Wk60nXymnhEg11E
         RyiV6KGgv19e7cQTB4fqwx5ddPiIcdQvIWEyxdtk5KjJxF8YVkRn8VxTxNou1UTXfN5d
         PzFKcNGRhV50gGp77OLnNo0Y0kU9LAHkjHl4n8T9GNgSi4jGIymmOTsbtJ70g7iCUrme
         8cFlt9w9oercSNiKEhLufiCW68I/ddAQZq5CDebSL8wOr5FNWj/Bhw836RDBEnR/4+q3
         NbfQ==
X-Gm-Message-State: AJIora+RNlZfFRllU390cSgrEXrE/5NYXOL/By7V/ydN7ol/Sucqf2NU
        ckIHR+8NovH5Gnt0+OKL9nyAtSjHeMB2fJlUDravXQ==
X-Google-Smtp-Source: AGRyM1uZga0NmMKKnrtL7tNwX0yv1AqXO6WwrAuYMFC0JhsER8PGlbr+vexB48sBx+y4/hFXsFUplNR17/2NCvfE8Y0=
X-Received: by 2002:a05:6402:430b:b0:43b:e639:8b25 with SMTP id
 m11-20020a056402430b00b0043be6398b25mr13083404edc.205.1658821693599; Tue, 26
 Jul 2022 00:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com> <20220721093422.2173982-2-marcus.folkesson@gmail.com>
In-Reply-To: <20220721093422.2173982-2-marcus.folkesson@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jul 2022 09:48:02 +0200
Message-ID: <CACRpkdZJZ6JwGDLdPHqb8WW+fN+tAYNDD-ERwo4h2ftZ0cGEqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpio: fairchild,74hc595: add
 strobe-gpios property
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 11:30 AM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:

> Some shift registers (74hc4094 for example) has a strobe signal to latch
> data from the serial input to the parallel output.
>
> Add an optional strobe-gpios property to support those chips.
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

As pointed out in discussion with Andy, let's drop this and just
use cs-gpios as-is.

Yours,
Linus Walleij
