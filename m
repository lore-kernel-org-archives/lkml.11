Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38727C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 00:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbiGHA4k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 20:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiGHA4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 20:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB8271BC2;
        Thu,  7 Jul 2022 17:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDF0361549;
        Fri,  8 Jul 2022 00:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB864C3411E;
        Fri,  8 Jul 2022 00:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657241796;
        bh=ayQK51zQUw6L0j2QP5jHygvivUNFb7EtQeLp3gQ4Twg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kc8Y3i1RZ5F7Wq74+CuWysW4VctMxt6YR101tUjXAcIkho6nYaISfcbTQdarzPjO4
         d+eAaFFLKbBRMCIQzKBCGyPN9hH6G+EXPlG+8IpWwLuDEFc5DnMyCiB44m4MM4cpO9
         2Vhqfc6sq+rI0NLKmKsDaxiao0WLjj4STr8Km63Dak8OW9GTBTw0Vg/5+fxY37Hrf8
         G5IrcEa4wHVIT2kwijf7/+4yJcuR4kwhOvqTAUFVggzn1GieU+/v6Mx7UeMDi2HZfs
         7ugxaGTtbcZM+z8fhowDIlEVDJqxi5ahGAfaMri5DVk7J4UEUuGP5eJgCjA78EniN9
         lY4QeaOcXFKeg==
Date:   Thu, 7 Jul 2022 17:56:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maksym Glubokiy <maksym.glubokiy@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: extract port range fields from
 fl_flow_key
Message-ID: <20220707175627.7c6fc403@kernel.org>
In-Reply-To: <20220707083539.171242-1-maksym.glubokiy@plvision.eu>
References: <20220707083539.171242-1-maksym.glubokiy@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 11:35:38 +0300 Maksym Glubokiy wrote:
> +/**
> + * flow_dissector_key_ports_range:
> + *		tp:     port number from packet
> + *		tp_min: min port number in range
> + *		tp_max: max port number in range
> + */

This is not valid kdoc, please see
Documentation/doc-guide/kernel-doc.rst

> +struct flow_dissector_key_ports_range {
> +	union {
> +		struct flow_dissector_key_ports tp;
> +		struct {
> +			struct flow_dissector_key_ports tp_min;
> +			struct flow_dissector_key_ports tp_max;
> +		};
> +	};
> +};

