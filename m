Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4006DC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbiCNUCb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 16:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbiCNUCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:02:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30710FC5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:01:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n19so29155712lfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=F5mU9o7savlVkOpAVXAc7vZgunxy8jXIc2Wup8XxmsY=;
        b=U9r3p6udDqYlZ1aopd62hIGt17gWQvQg7QbrFEqTQOh59FTbqt6d+jnOaxtuOemxUx
         fc8Cm//gfPrMpb46jCfiDzcT2SRuCSHU4LZvHM+j4uGUzaPmhhsaFt3Mra/xnGnwt3z1
         NvVVn/WRXQJVn3RMkkWAQxgRotPoF/Cf/qFIxY5bKHkOBrBM7//tpkLQf7zt1KFfgzD+
         YNEi7mazSo0xLGI7QHGT/qPi++c6x9OOylHKgsHWcp8raYtetaDbdH/UxwcuqaGuJmzX
         pX4Nj7n69fCKkgPH++8LHtka06ngmG4Ta9Hdb2RTKiknFDUEjkh7aClHpBD7jW+pFoBk
         zMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F5mU9o7savlVkOpAVXAc7vZgunxy8jXIc2Wup8XxmsY=;
        b=DPaUHg/XdQbYlAvgjlCthnc+pGJMtLISgUw0h0fB+u9gOzHLJZjV0ikgnVLmLtW+8K
         A7Ssh248UyZ0/n90NX2X6iGIA6ySiLl8vdIqSKQfXZk69krfsXp7pf6HeXi57GjlYIM3
         T3afmBtnyjGQ7YKYeZ24pZ199RuIKdsqWdRE23EiFdiA9inv5Y+6QkvIzu565SAdxAYh
         u8LNKEkWw8IiLTnA+Bt8w2t+vwFjtQnK+AS1YSGv8AZKTiXp1dsJorBqkqoEmmQOlic8
         5RhcmB3423hDuhMSQc4HZnu8XERFR4Oo4nmzxxX8IRt2dDJGb//7sPOXwmRf50CPFM+0
         4xZQ==
X-Gm-Message-State: AOAM531wx9KbCc+cWfdCvgI/PsXMTzvTMoo4eU4AWJb6Cb2GE/rI+I1e
        ftZiEk0fZUdgP2cU+GTCwzaFVknH+z4lhpjr/6o=
X-Google-Smtp-Source: ABdhPJyHDyPenGqPAi41TYDlo5mD300lE2AJ2gyHhdiUNZlkYSUqN58v0syL+saGgM1BBbx8/gwZZA==
X-Received: by 2002:ac2:4ac2:0:b0:448:373b:dca5 with SMTP id m2-20020ac24ac2000000b00448373bdca5mr14094527lfp.568.1647288075110;
        Mon, 14 Mar 2022 13:01:15 -0700 (PDT)
Received: from wkz-x280 (h-212-85-90-115.A259.priv.bahnhof.se. [212.85.90.115])
        by smtp.gmail.com with ESMTPSA id t10-20020ac24c0a000000b004482e94a3b5sm3431991lfq.16.2022.03.14.13.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:01:14 -0700 (PDT)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Russell King <linux@armlinux.org.uk>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Cooper Lees <me@cooperlees.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH v3 net-next 09/14] net: dsa: Validate hardware support
 for MST
In-Reply-To: <20220314175556.7mjr4tui4vb4i5qn@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-10-tobias@waldekranz.com>
 <20220314165649.vtsd3xqv7htut55d@skbuf>
 <20220314175556.7mjr4tui4vb4i5qn@skbuf>
Date:   Mon, 14 Mar 2022 21:01:12 +0100
Message-ID: <87mthsl2wn.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 19:55, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Mar 14, 2022 at 06:56:49PM +0200, Vladimir Oltean wrote:
>> > diff --git a/net/dsa/port.c b/net/dsa/port.c
>> > index 58291df14cdb..1a17a0efa2fa 100644
>> > --- a/net/dsa/port.c
>> > +++ b/net/dsa/port.c
>> > @@ -240,6 +240,10 @@ static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
>> >  	if (err && err != -EOPNOTSUPP)
>> >  		return err;
>> >  
>> > +	err = dsa_port_mst_enable(dp, br_mst_enabled(br), extack);
>> > +	if (err && err != -EOPNOTSUPP)
>> > +		return err;
>> 
>> Sadly this will break down because we don't have unwinding on error in
>> place (sorry). We'd end up with an unoffloaded bridge port with
>> partially synced bridge port attributes. Could you please add a patch
>> previous to this one that handles this, and unoffloads those on error?
>
> Actually I would rather rename the entire dsa_port_mst_enable() function
> to dsa_port_mst_validate() and move it to the beginning of dsa_port_bridge_join().
> This simplifies the unwinding that needs to take place quite a bit.

Well you still need to unwind vlan filtering if setting the ageing time
fails, which is the most complicated one, right? Still, I agree that
_validate is a better name, and then _bridge_join seems like a more
reasonable placement. Should the unwinding patch still be part of this
series then?

While we're here, I actually made this a hard error in both scenarios
(but forgot to update the log - will do that in v4, depending on what we
decide here). There's a dilemma:

- When reacting to the attribute event, i.e. changing the mode on a
  member we're apart of, we _can't_ return -EOPNOTSUPP as it will be
  ignored, which is why dsa_port_mst_validate (nee _enable) returns
  -EINVAL.

- When joining a bridge, we _must_ return -EOPNOTSUPP to trigger the
  software fallback.

Having something like this in dsa_port_bridge_join...

err = dsa_port_mst_validate(dp);
if (err == -EINVAL)
	return -EOPNOTSUPP;
else if (err)
	return err;

...works I suppose, but feels somewhat awkwark. Any better ideas?

