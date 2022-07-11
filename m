Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F71C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbiGKTaK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGKTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:30:08 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF05732B8B;
        Mon, 11 Jul 2022 12:30:07 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id r76so5866097iod.10;
        Mon, 11 Jul 2022 12:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b3yEB3Go+pE9ig6J6Qa9FEaP1GF3s6KwwZrn0irAjB0=;
        b=kbnCa78a1IACE8MwIfJ89EXAtJmQLKvA7vcra2r3NG23ClrhDJDT8KdB2kWcOaY020
         Tb35xXvSoLTit/qbJB4vDth6CbwSW6Z3+dCe09yUFbx+Mn69A+eo3/LJY/MomwI0acSQ
         sus0DuhFmjGZ5GR3E2uBHHpxXX2D48tXTjiS97QCvx6ywM0qCBg8C0kqnzehjbl6JrxQ
         6YWllNt++2EofbKxJA3P6HVhD6RdM5oy+Ge7/8TA2tXAV0vmsanrd0qxYQVfnqk06Z8R
         4XcpXIXf3lRNxGefvfDC+6eAIPRUiEGshkMq+7yCsFzpKGgVrLtoNyRzsAlfWmqPt5FF
         aJGQ==
X-Gm-Message-State: AJIora8HGbnCB1YEnFOoZ+kp/h8bYAFv/BgJvssjUZJkco5vaAYWR9gs
        acVE8Yj2qmE/9lwTtWFJZA==
X-Google-Smtp-Source: AGRyM1tzZKV4m0lkKkBmtNLJU+u8REcrOT3WM73Q0PtFkuQfDcLWvB9NtofF6qBbD4UZCA18b1jPUQ==
X-Received: by 2002:a02:c882:0:b0:33b:fb2e:9d49 with SMTP id m2-20020a02c882000000b0033bfb2e9d49mr10839803jao.218.1657567806987;
        Mon, 11 Jul 2022 12:30:06 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a16-20020a029f90000000b0033f58404535sm1561267jam.110.2022.07.11.12.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:30:06 -0700 (PDT)
Received: (nullmailer pid 139401 invoked by uid 1000);
        Mon, 11 Jul 2022 19:30:05 -0000
Date:   Mon, 11 Jul 2022 13:30:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Furkan Kardame <furkan@fkardame.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: amlogic: add Beelink GT1 Ultimate
 binding
Message-ID: <20220711193005.GA139368-robh@kernel.org>
References: <20220707093954.21716-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707093954.21716-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Jul 2022 09:39:53 +0000, Christian Hewitt wrote:
> Add the board binding for the Shenzen AZW (Beelink) GT1 Ultimate
> Android Set-Top Box device.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
